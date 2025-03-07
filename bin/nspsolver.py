#!/usr/bin/env python3
import datetime
import fcntl
import math
import signal
import socket
import threading
import time
import clingo
from clingo import Number, Function
import argparse

import colorama
from colorama import Fore, Style
from showmodel import make_shift_table, read_model
from make_legacy_model import make_legacy_model, parse_rectangles, should_process

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
    def __init__(self, files=None, output=None, clingo_options=None, strategy="default", lnps_interval=None, init_model_file=None, fixed_rects=[], clear_rects=[], show_model=None, show_table=False, timeout=None, verbose=0, stats=0):
        """
        Initialize the NSPSolver
        :param files: List of logic program files
        :param clingo_options: List of options to pass to Clingo
        :param verbose: Verbose level (0: silent, 1: basic, 2: detailed)
        """
        self.files = files if files else []
        self.output = output
        self.clingo_options = clingo_options if clingo_options else []
        self.strategy = strategy
        self.lnps_interval = lnps_interval
        self.is_lnps_time_expired = False
        self.lock = threading.Lock()
        self.fixed_rects = fixed_rects
        self.clear_rects = clear_rects
        self.show_model = show_model
        self.show_table = show_table
        self.timeout = timeout
        self.verbose = verbose
        self.stats = stats

        self.soften_hard = False
        self.must_wait_for_finding_model = init_model_file == None
        self.fixed_targets = []
        self.pritz_targets = []
        if init_model_file:
            self.soften_hard, self.fixed_targets, self.pritz_targets = make_legacy_model(init_model_file, fixed_rects, clear_rects)
        if init_model_file or self.strategy == "lnps":
            self.clingo_options.append("--heuristic=Domain")
            self.debug_print(f"Set heuristic to Domain")

        print(f"clingo_options = {self.clingo_options}")
        self.control = clingo.Control(self.clingo_options)
        self.start_time = None
        self.last_model = None
        self.last_cost = None
        self.table_width = None

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

        # Start the timer if a timeout is set
        if self.timeout:
            timer = threading.Timer(self.timeout, self.time_expired)
            timer.start()

        # Add Output fixed targets
        fixed_atoms = ["#show fixed/1."]
        for target in self.fixed_targets:
            fixed_atoms.append(f"fixed({target}).")
        fixed_statement = "\n".join(fixed_atoms)
        self.control.add("base", [], fixed_statement)
        self.debug_print("Fixed Statements:")
        self.debug_print(fixed_statement)

        # Add prioritized targets
        pritz_atoms = ["#show prioritized/1."]
        for target in self.pritz_targets:
            pritz_atoms.append(f"prioritized({target}).")
        pritz_statement = "\n".join(pritz_atoms)
        self.control.add("base", [], pritz_statement)
        self.debug_print("Prioritized Statements:")
        self.debug_print(pritz_statement)

        # Add heuristic for LNPS
        if self.strategy == "lnps":
            heuristic = "#heuristic ext_assigned(N,D,S) : prioritized(ext_assigned(N,D,S), t). [1, true]"
            self.control.add("prioritized", ["t"], heuristic)
            self.debug_print("Heuristic Statement:")
            self.debug_print("#program heuristic(t).")
            self.debug_print(heuristic)

            curr_pritz_targets = self.pritz_targets
            prev_pritz_atoms = []
            prev_cost = None

            self.lnps_timer = threading.Timer(self.lnps_interval, self.lnps_time_expired)
            self.lnps_timer.start()


        # Ground the logic program
        self.control.ground([("base", [])], context=NSPContext())

        # Solve the program
        disable_soften_hard = [(Function("soften_hard"), False)]  # Hard constraints are enabled
        enable_soften_hard  = [(Function("soften_hard"), True)]   # Hard constraints are relaxed to soft
        assumptions = enable_soften_hard if self.soften_hard else disable_soften_hard
        step = 0
        while True:
            step += 1

            if self.strategy == "lnps":
                for atom in prev_pritz_atoms:
                    self.control.release_external(atom)
                    self.debug_print(f"release external {atom}.")

                ext_statements = "#show prioritized/2."
                curr_pritz_atoms = []
                self.debug_print("External Statements:")
                self.debug_print("#program external(t).")
                for target in curr_pritz_targets:
                    atom = Function("prioritized", [target, Number(step)])
                    curr_pritz_atoms.append(atom)
                    ext_statements += f"#external {atom}."
                    self.debug_print(f"#external {atom}.")
                self.control.add("external", ["t"], ext_statements)
                self.control.ground([("external", [Number(step)])])
                self.control.ground([("prioritized", [Number(step)])])
                self.debug_print(f"Grounding external({step}) and heuristic({step})")

                self.debug_print(f"Assigning prioritized atoms for step {step}")
                for atom in curr_pritz_atoms:
                    self.control.assign_external(atom, True)
                    self.debug_print(f"assign external {atom} True.")

                prev_pritz_atoms = curr_pritz_atoms.copy()

                print("----------------------------------------------------------------------")
                print(f"Iteration #{step}")
                print("----------------------------------------------------------------------")

            with self.control.solve(assumptions=assumptions, on_model=self.on_model, on_finish=self.on_finish, async_=True) as handle:
                with condition:
                    while not stop_event.is_set():
                        condition.wait()  # Wait for an event to be notified (e.g., model found or stop signal)
                        if handle.wait(0):  # Check if the solving process is complete
                            break
                if stop_event.is_set():
                    handle.cancel()  # Cancel the solving process if a stop signal was set
                result = handle.get()  # Retrieve the final solving result
                if result.unsatisfiable:
                    if assumptions == disable_soften_hard:
                        print("UNSATISFIABLE")
                        print("Hard constraints are relaxed to soft ones.")
                        stop_event.clear()
                        assumptions = enable_soften_hard
                        self.soften_hard = True
                        continue
                    else:
                        break
                # print(f"result.exhausted: {result.exhausted}, result.interrupted: {result.interrupted}")
                with self.lock:
                    if self.is_lnps_time_expired and not result.exhausted and result.satisfiable:
                        curr_pritz_targets = []
                        for atom in self.last_model:
                            if atom.match("ext_assigned", 3):
                                day = atom.arguments[1].number
                                if self.table_width and 0 <= day < self.table_width:
                                    curr_pritz_targets.append(atom)
                        if self.last_cost == prev_cost:
                            self.lnps_interval *= 1.1
                        prev_cost = self.last_cost
                        stop_event.clear()
                        self.is_lnps_time_expired = False
                        self.lnps_timer = threading.Timer(self.lnps_interval, self.lnps_time_expired)
                        self.lnps_timer.start()
                        continue

                if self.timeout:
                    timer.cancel()
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
            print(f'Models       : {int(s["models"]["enumerated"])}')
            if get_cost() != None:
                print(f'  Optimum    : {"Yes" if result.exhausted else "No"}')
                print(f'Optimization : {get_cost()}')
            print(f'Time         : {s["times"]["total"]:.3f}s')
            print(f'CPU Time     : {s["times"]["cpu"]:.3f}s')
            if s['concurrency'] > 1:
                print(f'Threads      : {int(s["concurrency"])}')

        return result

    def on_model(self, model):
        """
        Callback method triggered when an answer set is found
        """
        elapsed = time.time() - self.start_time

        changed_shifts = None
        self.last_model = list(model.symbols(shown=True))
        self.last_model.sort()
        self.must_wait_for_finding_model = False
        str_atoms = []
        for atom in self.last_model:
            str_atoms.append(str(atom))
            if atom.match("changed_shifts", 1):
                changed_shifts = atom.arguments[0].number
            elif atom.match("table_width", 1):
                self.table_width = atom.arguments[0].number

        self.last_cost = ' '.join(map(str, model.cost))
        header = f"Answer: {model.number}, Cost: {self.last_cost}, Elapsed: {elapsed:.1f}s"
        if changed_shifts != None:
            header += f", #Changed: {changed_shifts}"
        if self.soften_hard:
            header = Fore.YELLOW + header + ", Soften hard constraints" + Style.RESET_ALL
        if self.verbose > 0 and not self.show_table:
            print(header)

        if self.output:
            with open(self.output, 'w') as f:
                fcntl.flock(f, fcntl.LOCK_EX)
                try:
                    f.write(f"header(\"{header}\").\n")
                    f.write(".\n".join(str_atoms) + ".")
                finally:
                    fcntl.flock(f, fcntl.LOCK_UN)

        if self.show_model == "show":
            print("Shown Atoms:")
            print("\n".join(str(atom) for atom in model.symbols(shown=True)))
        elif self.show_model == "all":
            print("All Atoms:")
            print("\n".join(str_atoms))

        if self.show_table:
            table = make_shift_table(self.last_model)
            if table:
                print(header)
                table.display()
            else:
                print("Error: model contains no shift assignments (ext_assigned/3).")

        if self.strategy == "lnps":
            self.lnps_timer.cancel()
            self.lnps_timer = threading.Timer(self.lnps_interval, self.lnps_time_expired)
            self.lnps_timer.start()

    def on_finish(self, result):
        stop_event.set()
        with condition:
            condition.notify_all()

    def time_expired(self):
        print(f"\nTime limit ({self.timeout}) exceeded! Stopping Clingo...")
        stop_event.set()
        with condition:
            condition.notify_all()

    def lnps_time_expired(self):
        with self.lock:
            # print(f"must_wait_for_finding_model = {self.must_wait_for_finding_model}")
            if self.must_wait_for_finding_model:
                self.lnps_timer = threading.Timer(self.lnps_interval, self.lnps_time_expired)
                self.lnps_timer.start()
                return
            print(f"\nLNPS time limit ({round(self.lnps_interval, 1)}) exceeded! Stopping Clingo...")
            self.is_lnps_time_expired = True
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


    def debug_print(self, *args, **kwargs):
        if self.verbose > 1:
            print(*args, **kwargs)

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

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="NSPSolver")

    # Positional argument
    parser.add_argument(
        "files",
        nargs="+",
        help="Logic program files (one or more)"
    )

    # Boolean flags
    parser.add_argument(
        "-m", action="store_true",
        help="Display only atoms specified by #show."
    )
    parser.add_argument(
        "-M", action="store_true",
        help="Display all atoms."
    )
    parser.add_argument(
        "-s", action="store_true",
        help=(
            "Display the shift table each time a model is found. "
            "However, since it is frequently displayed, it is recommended to use the showtable.py command."
        )
    )
    parser.add_argument(
        "--mono", action="store_true",
        help="Display output in monochrome (no colors)."
    )

    # Output file
    parser.add_argument(
        "-o", "--output",
        type=str, default="found-model.lp", metavar="MODEL_FILE",
        help="Output file for models (default: found-model.lp)"
    )

    # LNPS search strategy
    parser.add_argument(
        "--lnps",
        action="store_true",
        help="Enable LNPS mode (without destroy). If specified, LNPS will be used."
    )
    parser.add_argument(
        "--lnps-interval",
        type=int, default=10, metavar="SECONDS",
        help="Specify the interval length in terms of elapsed time since the last solution found"
    )

    # Initial assignment control
    parser.add_argument(
        "-i", "--init-model",
        type=str, nargs="?", const="found-model.lp", default=None,
        help="Specify the initial model file. If not specified, found-model.lp is used as default."
    )
    parser.add_argument(
        "-c", "--clear",
        type=str, action="append", default=[], metavar="AREA_DEF",
        help="Clear specific assignments (e.g., '-c d2-5,n3-6')"
    )
    parser.add_argument(
        "-f", "--fixed",
        type=str, action="append", default=[], metavar="AREA_DEF",
        help="Fix specific assignments (e.g., '-f d1-3,n2-4')"
    )

    # Others
    parser.add_argument(
        "--timeout",
        type=int, default=None, metavar="SECONDS", help="Time limit for solving (in seconds)")
    parser.add_argument(
        "-v", "--verbose",
        nargs="?", const=1, type=int, default=1, metavar="LV",
        help="Set verbosity level (0: silent, 1: basic, 2: detailed)"
    )
    parser.add_argument(
        "--stats",
        nargs="?", const=1, type=int, default=0, metavar="LV",
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

    # Search strategy
    strategy = "default"
    if args.lnps:
        strategy = "lnps"

    # Parse the fixed and clear areas for the initial assignment
    fixed_rects = parse_rectangles(args.fixed)
    clear_rects = parse_rectangles(args.clear)

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
        strategy=strategy,
        lnps_interval=args.lnps_interval,
        init_model_file=args.init_model,
        fixed_rects=fixed_rects,
        clear_rects=clear_rects,
        show_model=show_model,
        show_table=args.s,
        timeout=args.timeout,
        verbose=args.verbose,
        stats=args.stats,
    )

    # Load logic programs and solve
    solver.load_programs()
    solver.solve()
    print("Done.")

if __name__ == "__main__":
    main()
