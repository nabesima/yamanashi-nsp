#!/usr/bin/env python3
import argparse
import fcntl
import os
import sys
import time
import clingo
from colorama import Fore, Style
import pandas as pd

class ShiftTable:
    def __init__(self, df, title=None, penalties=[]):
        self.df = df
        self.title = title
        self.penalties = penalties

class Penalty:
    def __init__(self, type, cause, location, limit, value, wegiht, priority):
        self.type = type
        self.cause = cause
        self.location = location
        self.limit = limit
        self.value = value
        self.weight = wegiht
        self.priority = priority

def make_shift_table(atoms):
    header = None
    assigneds = []
    dates = []
    penalties = []
    for atom in atoms:   
        args = atom.arguments            
        if atom.match("header", 1):
            header = args[0].string
        elif atom.match("ext_assigned", 3):
            staff = args[0].number
            date  = args[1].number
            s     = args[2].string
            assigneds.append({'No': staff, 'Date': date, 'Shift': s})
        elif atom.match("out_date", 3):
            r_day = args[0].number
            a_day = args[1].number % 100
            dweek = args[2].string
            dates.append((r_day, a_day, dweek))
        elif atom.match("penalty", 7):
            ctype = args[0]
            cause = args[1]
            loc   = args[2]
            lim   = args[3].number
            val   = args[4].number
            w     = args[5].number
            p     = args[6].number
            # penalties.append(Penalty(ctype, cause, loc, lim, val, w, p))
            penalties.append({
                'Type': ctype,
                'Cause': cause,
                'Loc': loc,
                'Lim': lim,
                'Val': val,                
                'P': p,
                'W': w,
            })

    df = pd.DataFrame(assigneds)

    # Checking duplicated entries
    duplicates = df[df.duplicated(subset=['No', 'Date'], keep=False)]
    if not duplicates.empty:
        print("=== Error: Duplicate Entries Detected ===")
        print(duplicates)
        print("=========================================")

    df_tbl = df.pivot(index='No', columns='Date', values='Shift')

    # Add dates
    dates = sorted(dates)
    df_tbl.columns = pd.MultiIndex.from_tuples(dates)   

    # print(df_tbl)
    # self.print_shift_table(df_tbl)  
    return ShiftTable(df_tbl, header, penalties)  

def print_shift_table(table, color=True):
    
    df = table.df.fillna("  ")
    
    col_headers = [[""] + list(col) for col in zip(*df.columns.tolist())]
    data_rows = [[index] + row.tolist() for index, row in zip(df.index, df.values)]
    full_table = col_headers + data_rows
    
    def format_cell(val, row, col):
        if not color:
            return f"{str(val):<2}"
        w = col_headers[2][col]
        c = ""
        if row < 3:
            if w == "Sa":
                c = Fore.BLUE
            elif w == "Su" or w == "PH":
                c = Fore.RED
        elif col > 0:
            if val == "D":
                c = Fore.GREEN
            elif val == "LD" or val == "SE" or val == "SN":
                c = Fore.CYAN
            elif val == "E" or val == "N":
                c = Fore.BLUE
            elif val == "EM" or val == "LM":
                c = Fore.YELLOW
            elif val == "WR" or val == "PH":
                c = Style.DIM
            else:
                c = Fore.MAGENTA
        return c + f"{str(val):<2}" + Style.RESET_ALL

    # Formatting cells
    full_table = [
        [format_cell(value, row_idx, col_idx) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(full_table)
    ]

    if table.title:
        print(table.title)
    for idx, row in enumerate(full_table):
        if idx == 3:
            print("-" * 134)
        line  = row[0] + " | "
        line += ' '.join(row[1:8]) + " | "
        line += ' '.join(row[8:36]) + " | "
        line += ' '.join(row[36:])
        print(line)

    # Penalties    
    pf = pd.DataFrame(table.penalties)
    pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)
    pf.index += 1
    print("Penalties:")
    print(pf[['P', 'W', 'Type', 'Cause', 'Lim', 'Val']].to_string())

def read_model(file, color):
    try:
        with open(file, 'r') as f:
            fcntl.flock(f, fcntl.LOCK_SH)
            try:
                content = f.read()
            finally:
                fcntl.flock(f, fcntl.LOCK_UN)
    except FileNotFoundError:
        print(f"Error: File '{file}' not found.")
        sys.exit(1)
    
    atoms = parse_model(content)
    table = make_shift_table(atoms)
    print_shift_table(table, color)

def monitor_file(file, interval, color):
    """Monitor the file for changes and reload when updated."""
    last_modified = None
    while True:
        try:
            current_modified = os.path.getmtime(file)
            if current_modified != last_modified:
                last_modified = current_modified
                read_model(file, color)
            time.sleep(interval)              
        except FileNotFoundError:
            print(f"File '{file}' not found. Waiting for it to be created...")
            time.sleep(interval)

def parse_model(content):
    atoms = []
    for fact in content.split("\n"):
        fact = fact.strip().rstrip(".")
        if fact:  # Skip empty strings
            try:
                atom = clingo.parse_term(fact)
                atoms.append(atom)
            except RuntimeError as e:
                print(f"Error parsing fact '{fact}': {e}")
    return atoms

def main():
    parser = argparse.ArgumentParser(description="Read a model from a file or standard input.")
    parser.add_argument("file", nargs="?", default="found-model.lp", help="Model file to read. Defaults to 'found-model.lp'.")
    parser.add_argument("-m", "--monochrome", action="store_true", help="Display output in monochrome (no colors).")
    parser.add_argument("-f", "--follow", type=float, nargs="?", const=1.0, help="Monitor the file for changes and reload when updated. Specify interval in seconds (default: 1 second).")

    args = parser.parse_args()

    if args.follow:
        monitor_file(args.file, interval=args.follow, color=not args.monochrome)
    else:
        read_model(args.file, color=not args.monochrome)

if __name__ == "__main__":
    main()