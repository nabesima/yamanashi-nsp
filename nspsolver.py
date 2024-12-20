#!/usr/bin/env python3
import fcntl
import math
import signal
import threading
import time
import clingo
import argparse
from showmodel import make_shift_table, print_shift_table

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
    def __init__(self, files=None, output=None, clingo_options=None, show_model=None, show_table=False, verbose=0, stats=0):
        """
        Initialize the NSPSolver
        :param files: List of logic program files
        :param clingo_options: List of options to pass to Clingo
        :param verbose: Verbose level (0: silent, 1: basic, 2: detailed)
        """
        self.files = files if files else []
        self.output = output
        self.clingo_options = clingo_options if clingo_options else []
        self.show_model = show_model
        self.show_table = show_table
        self.verbose = verbose
        self.stats = stats
        self.control = clingo.Control(self.clingo_options)
        self.start_time = None

        if self.verbose > 0:
            print(f"clingo options: {' '.join(self.clingo_options)}")

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
        # result = self.control.solve(on_model=self.on_model)
        # print(f"Solve Result: {result.satisfiable}")
        with self.control.solve(on_model=self.on_model, on_finish=self.on_finish, async_=True) as handle:
            with condition:
                while not stop_event.is_set():
                    condition.wait()  # Wait for an event to be notified (e.g., model found or stop signal)
                    if handle.wait(0):  # Check if the solving process is complete
                        break
            if stop_event.is_set():
                handle.cancel()  # Cancel the solving process if a stop signal was set
            result = handle.get()  # Retrieve the final solving result

        print(f"Solve Result: {result}")

        # Print statistics if solving was successful
        if self.stats:
            self.print_statistics()

        return result

    def on_model(self, model):
        """
        Callback method triggered when an answer set is found
        """
        elapsed = time.time() - self.start_time
        self.model = model

        header = f"Answer: {model.number}, Cost: {' '.join(map(str, model.cost))}, Elapsed: {elapsed:.1f}s"
        print(header)

        if self.show_model == "show":
            print("Shown Atoms:")
            print("\n".join(str(atom) for atom in model.symbols(shown=True)))
        elif self.show_model == "all":
            print("All Atoms:")
            print("\n".join(str(atom) for atom in model.symbols(atoms=True)))

        if self.show_table:
            table = make_shift_table(model.symbols(atoms=True))
            print_shift_table(table)

        if self.output:
            atoms = "\n".join([str(atom) + "." for atom in model.symbols(atoms=True)])            
            with open(self.output, 'w') as f:
                fcntl.flock(f, fcntl.LOCK_EX)
                try:
                    f.write(f"header(\"{header}\").\n")
                    f.write(atoms)
                finally:
                    fcntl.flock(f, fcntl.LOCK_UN)

    def on_finish(self, result):
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
    parser.add_argument("-t", action="store_true", help="Display the shift table each time a model is found. However, since it is frequently displayed, it is recommended to use the showtable.py command." )
    parser.add_argument("-o", "--output", type=str, default="found-model.lp", help="Output file for models (default: found-model.lp)")
    parser.add_argument(
        "-v", "--verbose",
        nargs="?",  # Optional argument with a default value if specified without a value
        const=1,  # Default to 1 if -v is specified without a value
        type=int,  # Ensure the verbose level is an integer
        default=1,  # Default to 0 if -v is not specified
        help="Set verbosity level (0: silent, 1: basic, 2: detailed)"
    )
    parser.add_argument(
        "-s", "--stats",
        nargs="?",  # Optional argument with a default value if specified without a value
        const=1,  # Default to 1 if -s is specified without a value
        type=int,  # Ensure the verbose level is an integer
        default=0,  # Default to 0 if -s is not specified
        help="Set statistics level (0: silent, 1: basic, 2: detailed)"
    )    
    # Pass unrecognized arguments to Clingo
    args, unknown_args = parser.parse_known_args()

    # Display found models?
    show_model = None
    if args.m:
        show_model = "show"
    if args.M:
        show_model = "all"

    # シグナルハンドラを登録
    signal.signal(signal.SIGINT, signal_handler)


    # Create an NSPSolver instance
    solver = NSPSolver(
        files=args.files, 
        output=args.output, 
        clingo_options=unknown_args, 
        show_model=show_model, 
        show_table=args.t,
        verbose=args.verbose, 
        stats=args.stats,
    )
    
    # Load logic programs and solve
    solver.load_programs()
    solver.solve()

if __name__ == "__main__":
    main()
