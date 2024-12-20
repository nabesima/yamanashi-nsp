#!/usr/bin/env python3
import argparse
import fcntl
import os
import sys
import time
import clingo
from colorama import Back, Fore, Style
import pandas as pd

class ShiftTable:
    def __init__(self, df, title, width, df_shift, penalties, penalty_map):
        self.df = df
        self.title = title
        self.width = width
        self.df_shift = df_shift
        self.penalties = penalties
        self.penalty_map = penalty_map

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
    htypes = []
    for atom in atoms:   
        args = atom.arguments            
        if atom.match("header", 1):
            header = args[0].string
        elif atom.match("table_width", 1):
            width = args[0].number
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
        elif atom.match("horizontal_constraint_type", 1):
            shift_group  = args[0].string
            htypes.append(shift_group)

    # Shift assignments
    df = pd.DataFrame(assigneds)

    # Checking duplicated entries
    duplicates = df[df.duplicated(subset=['No', 'Date'], keep=False)]
    if not duplicates.empty:
        print("=== Error: Duplicate Entries Detected ===")
        print(duplicates)
        print("=========================================")

    # ------------------------------------------------------------
    # Make a shift table
    df_tbl = df.pivot(index='No', columns='Date', values='Shift')

    # Add dates header to the shift table
    dates = sorted(dates)
    # Add missing dates
    for date in dates:
        if not date[0] in df_tbl.columns:
            df_tbl[date[0]] = None
    df_tbl = df_tbl.sort_index(axis='columns')           
    df_tbl.columns = pd.MultiIndex.from_tuples(dates)   

    # print(df_tbl)
    # self.print_shift_table(df_tbl)  

    # ------------------------------------------------------------
    # Make a table of the number of assigned shifts
    cur_df = df[(0 <= df['Date']) & (df['Date'] <= width)]  # current month
    # print("1"); print(cur_df)
    # Extend the dataframe to count the number of assigned shift groups
    shift_groups = [sg for sg in htypes if '+' in sg]
    for shift_group in shift_groups:
        for shift in shift_group.split("+"):
            tmp_df = cur_df[cur_df['Shift'] == shift].copy()
            tmp_df['Shift'] = shift_group
            cur_df = pd.concat([cur_df, tmp_df])
    # print("(2)"); print(cur_df)    
    gdf = cur_df.groupby(['No', 'Shift']).count().reset_index() # Count assigned shift groups
    gdf = gdf.pivot(index='No', columns='Shift', values='Date') # Convert to the table
    gdf = gdf.reindex(columns=htypes) # Change the column order
    gdf = gdf.fillna(0).astype(int) # Convert to int
    #print(gdf)
    df_shifts = gdf

    # ------------------------------------------------------------
    # Make a penalty mapping
    penalty_map = make_penalty_map(penalties)
    #print(f'penalty_map = {penalty_map}')

    return ShiftTable(df_tbl, header, width, df_shifts, penalties, penalty_map)  

def make_penalty_map(penalties):
    map = {}
    def add(row, col, p):
        if row not in map:
            map[row] = {}
        if col not in map[row]:
            map[row][col] = []
        map[row][col].append(p)

    for p in penalties:
        cause = p['Cause']
        args = cause.arguments
        if cause.match("shift_lb", 2) or cause.match("shift_ub", 2):
            staff = args[0].number
            shift_group = args[1].string
            add(staff, shift_group, p)
    
    return map

def print_shift_table(table, color=True):
    
    def format_main_cell(val, row, col):
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
    
    df = table.df.fillna("  ")
    col_headers = [[""] + list(col) for col in zip(*df.columns.tolist())]
    data_rows = [[index] + row.tolist() for index, row in zip(df.index, df.values)]
    main_table = col_headers + data_rows

    # Formatting cells
    main_table = [
        [format_main_cell(value, row_idx, col_idx) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(main_table)
    ]

    def has_penalty(row, col):
        if row in table.penalty_map:
            return col in table.penalty_map[row]
        return False

    def format_right_cell(val, row, shift_group, width):
        c = ""
        if has_penalty(row, shift_group):
            c = Back.RED
        return c + str(val).center(width) + Style.RESET_ALL

    # Make a right table of the number of assgned shifts
    col_headers = list(table.df_shift.columns)
    col_width = list(map(len, col_headers))
    col_width = list(map(lambda n: max(2, n), col_width))
    right_width = sum(col_width) + len(col_headers)
    data_rows = table.df_shift.values.tolist()
    right_table = [col_headers] + data_rows
    right_table = [
        [format_right_cell(value, row_idx, col_headers[col_idx], col_width[col_idx]) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(right_table)
    ]

    if table.title:
        print(table.title)
    for idx, row in enumerate(main_table):
        # main table
        if idx == 3:
            print("-" * (3 * (table.width + 14 + 4) + right_width)) # 14 days and 3 separators
        line  = row[0] + " | "
        line += ' '.join(row[1:8]) + " | "
        line += ' '.join(row[8:table.width + 8]) + " | "
        line += ' '.join(row[table.width + 8:]) + " | "
        # right table
        if 1 == idx:
            line += '# assigned shifts'.center(right_width)
        elif 2 <= idx:
            line += ' '.join(right_table[idx - 2])
        
        print(line)

    # Penalties    
    if len(table.penalties) > 0:
        pf = pd.DataFrame(table.penalties)
        pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)
        pf.index += 1
        print("Penalties:")
        print(pf[['P', 'W', 'Type', 'Cause', 'Lim', 'Val']].to_string())
    else:
        print("Penalties:")
        print("  None")
    print()

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