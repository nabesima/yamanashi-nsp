#!/usr/bin/env python3
import datetime
import fcntl
import math
import signal
import socket
import threading
import time
import clingo
import argparse

from colorama import Fore, Style
import colorama
from showmodel import make_shift_table, read_model

# An event flag to signal when the solving process should stop (e.g., triggered by Ctrl+C).
stop_event = threading.Event()
# A condition variable to manage notifications between threads (e.g., for model update or stopping).
condition = threading.Condition()

# Ctrl+C signal handler
def signal_handler(sig, frame):
    print("\nCtrl+C detected! Stopping Clingo...")
    stop_event.set()
    with condition:
        condition.notify_all()

class NSPSolver:
    def __init__(self, files=None, output=None, clingo_options=None, soften_hard=False, show_model=None, show_table=False, verbose=0, stats=0):
        """
        Initialize the NSPSolver
        :param files: List of logic program files
        :param clingo_options: List of options to pass to Clingo
        :param verbose: Verbose level (0: silent, 1: basic, 2: detailed)
        """
        self.files = files if files else []
        self.output = output
        self.clingo_options = clingo_options if clingo_options else []
        self.soften_hard = soften_hard
        self.show_model = show_model
        self.show_table = show_table
        self.verbose = verbose
        self.stats = stats
        self.control = clingo.Control(self.clingo_options)
        self.start_time = None

    def load_programs(self):
        """
        Load logic programs from the specified files
        """
        for file in self.files:
            try:
                self.control.load(file)
            except Exception as e:
                print(f"Failed to load file {file}: {e}")
                raise

    def solve(self):
        """
        Solve the logic programs and print the results
        """
        self.start_time = time.time()

        # Ground the logic program
        self.control.ground([("base", [])], context=NSPContext())

        # Solve the program
        disable_soften_hard = [(clingo.Function("soften_hard"), False)]  # Hard constraints are enabled
        enable_soften_hard  = [(clingo.Function("soften_hard"), True)]   # Hard constraints are relaxed to soft
        assumptions = enable_soften_hard if self.soften_hard else disable_soften_hard
        while True:
            with self.control.solve(assumptions=assumptions, on_model=self.on_model, on_finish=self.on_finish, async_=True) as handle:
                with condition:
                    while not stop_event.is_set():
                        condition.wait()  # Wait for an event to be notified (e.g., model found or stop signal)
                        if handle.wait(0):  # Check if the solving process is complete
                            break
                if stop_event.is_set():
                    handle.cancel()  # Cancel the solving process if a stop signal was set
                result = handle.get()  # Retrieve the final solving result
                if result.unsatisfiable and assumptions == disable_soften_hard:
                    print("UNSATISFIABLE")
                    print("Hard constraints are relaxed to soft ones.")
                    stop_event.clear()
                    assumptions = enable_soften_hard
                    self.soften_hard = True
                    continue
                break

        def get_cost():
            s = self.control.statistics['summary']
            if len(s['costs']) == 0:
                return None
            if s['costs'][0] == math.inf:
                return None
            return " ".join([str(int(c)) for c in self.control.statistics['summary']['costs']])

        if result.unsatisfiable:
            print("UNSATISFIABLE")
        elif result.unknown:
            print("UNKNOWN")
        elif result.satisfiable:
            if get_cost():
                print(f"Optimization: {get_cost()}")
            if result.exhausted:
                print("OPTIMUM FOUND")
            else:
                print("SATISFIABLE")
        print()
        #print(f"Solve Result: {dir(result)}")

        # Print statistics
        if self.stats:
            self.print_statistics()
            print()
        if self.verbose > 0:
            s = self.control.statistics['summary']
            print(f'Models       : {int(s['models']['enumerated'])}')
            if get_cost() != None:
                print(f'  Optimum    : {"Yes" if result.exhausted else "No"}')
                print(f'Optimization : {get_cost()}')
            print(f'Time         : {s['times']['total']:.3f}s')
            print(f'CPU Time     : {s['times']['cpu']:.3f}s')
            if s['concurrency'] > 1:
                print(f'Threads      : {int(s['concurrency'])}')

        return result

    def on_model(self, model):
        """
        Callback method triggered when an answer set is found
        """
        elapsed = time.time() - self.start_time

        header = f"Answer: {model.number}, Cost: {' '.join(map(str, model.cost))}, Elapsed: {elapsed:.1f}s"
        if self.soften_hard:
            header = Fore.YELLOW + header + ", Soften hard constraints" + Style.RESET_ALL
        if self.verbose > 0:
            print(header)

        if self.output:
            atoms = "\n".join([str(atom) + "." for atom in model.symbols(atoms=True)])
            with open(self.output, 'w') as f:
                fcntl.flock(f, fcntl.LOCK_EX)
                try:
                    f.write(f"header(\"{header}\").\n")
                    f.write(atoms)
                finally:
                    fcntl.flock(f, fcntl.LOCK_UN)

        if self.show_model == "show":
            print("Shown Atoms:")
            print("\n".join(str(atom) for atom in model.symbols(shown=True)))
        elif self.show_model == "all":
            print("All Atoms:")
            print("\n".join(str(atom) for atom in model.symbols(atoms=True)))

        if self.show_table:
            table = make_shift_table(model.symbols(atoms=True))
            if table:
                table.display()
            else:
                print("Error: model contains no shift assignments (ext_assigned/3).")

    def on_finish(self, result):
        stop_event.set()
        with condition:
            condition.notify_all()

    def print_statistics(self, d=None, indent=0):

        def try_to_int(n):
            # Check if the value is a float with .0 and convert it to an integer
            if isinstance(n, float) and n.is_integer():
                return int(n)
            return n

        if d == None:
            d = self.control.statistics
            print("Stats ------------------------------------------------------")
        for key, value in d.items():
            if isinstance(value, dict):  # If the value is a dictionary, process recursively
                if self.stats <= 1 and len(value) == 0:
                    continue
                print(" " * indent + f"{key}:")
                self.print_statistics(value, indent + 2)
            elif isinstance(value, list) and len(value) > 0:  # If the value is a list, format each item
                value = list(map(try_to_int, value))
                print(" " * indent + f"{key}: {value}")
            else:  # For other data types, print the key and value on the same line
                value = try_to_int(value)
                if self.stats <= 1 and isinstance(value, list) and len(value) == 0:
                    continue
                if self.stats <= 1 and value == 0:
                    continue
                print(" " * indent + f"{key}: {value}")

# Gounding helper functions
class NSPContext:
    def weekly_holidays_lb(self, width, hh, dwh):
        width = width.number
        hh    = hh.number
        dwh   = dwh.number
        return clingo.Number(math.floor(float(width - hh) / float(width) * dwh))

    def weekly_holidays_ub(self, width, hh, dwh):
        width = width.number
        hh    = hh.number
        dwh   = dwh.number
        return clingo.Number(math.ceil(float(width - hh) / float(width) * dwh))

    def max(self, n, m):
        n = n.number
        m = m.number
        return clingo.Number(n if n > m else m)

def make_prioritized_model(in_file: str, out_file: str):
    soften_hard = False
    atoms = read_model(in_file)
    with open(out_file, 'w') as out:
        for atom in atoms:
            if atom.match("assigned", 2) or atom.match("assigned", 3):
                print(f'legacy({atom}).', file=out)
            elif atom.match("soften_hard", 0):
                soften_hard = True
    return soften_hard

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="NSPSolver")
    parser.add_argument(
        "files",
        nargs="+",
        help="Logic program files (one or more)"
    )
    parser.add_argument("-m", action="store_true", help="Display only atoms specified by #show.")
    parser.add_argument("-M", action="store_true", help="Display all atoms.")
    parser.add_argument("-s", action="store_true", help="Display the shift table each time a model is found. However, since it is frequently displayed, it is recommended to use the showtable.py command." )
    parser.add_argument("-o", "--output", type=str, default="found-model.lp", help="Output file for models (default: found-model.lp)")
    parser.add_argument("-p", "--prioritize", nargs="?", type=str, const="found-model.lp", help="Specify the file containing the model to prioritize during search")
    parser.add_argument("--mono", action="store_true", help="Display output in monochrome (no colors).")
    parser.add_argument(
        "-v", "--verbose",
        nargs="?",  # Optional argument with a default value if specified without a value
        const=1,  # Default to 1 if -v is specified without a value
        type=int,  # Ensure the verbose level is an integer
        default=1,  # Default to 0 if -v is not specified
        help="Set verbosity level (0: silent, 1: basic, 2: detailed)"
    )
    parser.add_argument(
        "--stats",
        nargs="?",  # Optional argument with a default value if specified without a value
        const=1,  # Default to 1 if -s is specified without a value
        type=int,  # Ensure the verbose level is an integer
        default=0,  # Default to 0 if -s is not specified
        help="Set statistics level (0: silent, 1: basic, 2: detailed)"
    )
    # Pass unrecognized arguments to Clingo
    args, clingo_args = parser.parse_known_args()

    # Display found models?
    show_model = None
    if args.m:
        show_model = "show"
    if args.M:
        show_model = "all"

    # Set color mode
    colorama.init(strip=args.mono)

    # If a prioritized model file is specified, extract the assigned predicates from the model
    # and prioritize them.
    soften_hard = False
    if args.prioritize:
        soften_hard = make_prioritized_model(args.prioritize, "prioritized-model.lp")
        args.files.append("prioritized-model.lp")
        clingo_args.append("--heuristic=Domain")

    # Add signal hander
    signal.signal(signal.SIGINT, signal_handler)

    if args.verbose > 0:
        print(f'Host: {socket.getfqdn()}')
        print(f'Date: {datetime.datetime.now()}')
        cmd = ["clingo"]
        cmd += args.files
        cmd += clingo_args
        print(f'Command: {" ".join(cmd)}')

    # Create an NSPSolver instance
    solver = NSPSolver(
        files=args.files,
        output=args.output,
        clingo_options=clingo_args,
        soften_hard=soften_hard,
        show_model=show_model,
        show_table=args.s,
        verbose=args.verbose,
        stats=args.stats,
    )

    # Load logic programs and solve
    solver.load_programs()
    solver.solve()

if __name__ == "__main__":
    main()
