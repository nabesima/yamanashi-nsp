#!/usr/bin/env python3
import argparse
from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime, timedelta
import fcntl
import os
import sys
import time
import clingo
from colorama import Back, Fore, Style
import colorama
import pandas as pd

class ShiftTable:
    def __init__(self, df, title, first_date, width, df_shifts, df_staffs, penalties, penalty_map, assigned_map, request_map):
        self.df = df
        self.title = title
        self.first_date = first_date
        self.width = width
        self.df_shifts = df_shifts
        self.df_staffs = df_staffs
        self.penalties = penalties
        self.penalty_map = penalty_map
        self.assigned_map = assigned_map
        self.request_map = request_map

class Penalty:
    def __init__(self, type, cause, location, request, result, wegiht, priority):
        self.type = type
        self.cause = cause
        self.location = location
        self.request = request
        self.result = result
        self.weight = wegiht
        self.priority = priority

# Create a recursive defaultdict
def recursive_defaultdict():
    return defaultdict(recursive_defaultdict)

def make_shift_table(atoms):
    header = None
    first_date = None
    width = None
    assigneds = []
    dates = []
    staffs = []
    staff_groups = []
    penalties = []
    requests = []
    htypes = []
    vtypes = []
    for atom in atoms:
        args = atom.arguments
        if atom.match("header", 1):
            header = args[0].string
        elif atom.match("first_full_date", 1):
            first_date = datetime.strptime(str(args[0].number), "%Y%m%d")
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
        elif atom.match("staff", 5):
            no    = args[0].number
            name  = args[1].string
            job   = args[2].string
            id    = args[3].string
            point = args[4].number
            staffs.append((no, name, job, id, point))
        elif atom.match("staff_group", 2):
            gname = args[0].string
            staff = args[1].number
            staff_groups.append({'StaffGroup': gname, 'No': staff})
        elif atom.match("penalty", 6):
            ctype = args[0]
            cause = args[1]
            req   = args[2].number
            res   = args[3].number
            w     = args[4].number
            p     = args[5].number
            penalties.append({
                'Type': ctype,
                'Cause': cause,
                'Req': req,
                'Res': res,
                'P': p,
                'W': w,
            })
        elif atom.match("pos_request", 3):
            requests.append({'Type': 'pos', 'No': args[0].number, 'Date': args[1].number, 'Shift': args[2].string})
        elif atom.match("neg_request", 3):
            requests.append({'Type': 'neg', 'No': args[0].number, 'Date': args[1].number, 'Shift': args[2].string})
        elif atom.match("horizontal_constraint_type", 1):
            shift_group  = args[0].string
            htypes.append(shift_group)
        elif atom.match("vertical_constraint_type", 3):
            staff_group = args[0].string
            shift_group = args[1].string
            obj_type = args[2].string
            vtypes.append({'StaffGroup': staff_group, 'ShiftGroup': shift_group, 'ObjType': obj_type})

    if len(assigneds) == 0:
        return None

    # Shift assignments
    df = pd.DataFrame(assigneds)

    # Checking duplicated entries
    duplicates = df[df.duplicated(subset=['No', 'Date'], keep=False)]
    if not duplicates.empty:
        print("=== Error: Duplicate Entries Detected ===")
        print(duplicates)
        print("=========================================")

    # ------------------------------------------------------------
    # Make the shift table
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
    # Make the table of the number of assigned shifts (horizontal)
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
    # Make the table of the number of assigned staffs (vertical)
    gdf = pd.DataFrame(staff_groups)
    #print(gdf)
    # Add staff group to df
    mdf = pd.merge(cur_df, gdf, on='No', how='outer')
    # print(mdf)
    # Add staff point to df
    sdf = pd.DataFrame(staffs, columns=['No', 'Name', 'Job', 'ID', 'Point'])
    sdf = sdf[["No", "Point"]]
    mdf = pd.merge(mdf, sdf, on='No', how='outer')
    # print(mdf)
    # Extend the dataframe to count the number of assigned shift groups
    shift_groups = [vtype['ShiftGroup'] for vtype in vtypes if '+' in vtype['ShiftGroup']]
    shift_groups = list(dict.fromkeys(shift_groups))
    for shift_group in shift_groups:
        for shift in shift_group.split("+"):
            tmp_df = mdf[mdf['Shift'] == shift].copy()
            tmp_df['Shift'] = shift_group
            mdf = pd.concat([mdf, tmp_df])
    #print(mdf)
    mdf = mdf.groupby(['Date', 'StaffGroup', 'Shift']).agg({'Shift': 'count', 'Point': 'sum'})
    mdf = mdf.rename(columns={'Shift': 'Staffs', 'Point': 'Points'})
    mdf = mdf.stack().unstack('Date')
    #print(mdf)
    # Remove unconstrained rows
    idx = [(vtype['StaffGroup'], vtype['ShiftGroup'], vtype['ObjType']) for vtype in vtypes]
    mdf = mdf.reindex(idx)
    mdf = mdf.fillna(0).astype(int)  # Convert to int
    # Add days if not exist
    for date in range(0, width):
        if not (date in mdf.columns):
            mdf[date] = 0
    mdf = mdf.sort_index(axis='columns')
    df_staffs = mdf.rename(index={'Staffs': '#S', 'Points': '#P'})

    # ------------------------------------------------------------
    # Make the penalty mapping
    penalty_map = make_penalty_map(penalties)
    #print(f'penalty_map = {penalty_map}')

    # ------------------------------------------------------------
    # Make the assignment mapping for the explanation of penalties
    assigned_map = recursive_defaultdict()
    for a in assigneds:
        assigned_map[a["No"]][a["Date"]] = a["Shift"]

    # ------------------------------------------------------------
    # Make the request mapping for the explanation of penalties
    request_map = recursive_defaultdict()
    for r in requests:
        request_map[r["No"]][r["Date"]][r["Type"]].setdefault("Shift", []).append(r["Shift"])

    return ShiftTable(df_tbl, header, first_date, width, df_shifts, df_staffs, penalties, penalty_map, assigned_map, request_map)

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
        if cause.match("work_days_lb", 1) or cause.match("work_days_ub", 1) or cause.match("weekly_rest_lb", 1) or cause.match("weekly_rest_ub", 1):
            staff = args[0].number
            add(staff, -8, p)
        elif cause.match("shift_lb", 2) or cause.match("shift_ub", 2):
            staff = args[0].number
            shift_group = args[1].string
            add(staff, shift_group, p)
        elif cause.match("staff_lb", 3) or cause.match("staff_ub", 3):
            staff_group = args[0].string
            shift_group = args[1].string
            day = args[2].number
            row = (staff_group, shift_group, "#S")
            add(row, day, p)
        elif cause.match("consecutive_work_days", 2) or cause.match("pos_request", 2) or cause.match("neg_request", 2) or cause.match("forbidden_pattern", 3) or cause.match("next_shift", 3) or cause.match("prev_shift", 3):
            staff = args[0].number
            day = args[1].number
            add(staff, day, p)
        else:
            raise ValueError(f'Unknown penalty cause: {cause}')

    return map

def print_shift_table(table):

    def has_request(row, col):
        if row in table.request_map:
            return col in table.request_map[row]
        return False

    def has_penalty(row, col):
        if row in table.penalty_map:
            return col in table.penalty_map[row]
        return False

    def format_main_cell(val, row, col):
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
        if has_request(row - 2, col - 8):
            c = Fore.BLACK + Back.GREEN
        if has_penalty(row - 2, col - 8):
            c = Back.RED
        return c + str(val).center(2) + Style.RESET_ALL

    df = table.df.fillna("  ")
    col_headers = [[""] + list(col) for col in zip(*df.columns.tolist())]
    data_rows = [[index] + row.tolist() for index, row in zip(df.index, df.values)]
    main_table = col_headers + data_rows

    # Formatting cells
    main_table = [
        [format_main_cell(value, row_idx, col_idx) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(main_table)
    ]
    # Add the current month
    if table.first_date:
        month = (table.first_date - timedelta(days=7)).month
        main_table[1][0] = ["Ja", "Fe", "Ma", "Ap", "My", "Ju", "Jl", "Au", "Se", "Oc", "No", "De"][month-1]

    def format_right_cell(val, row, shift_group, width):
        c = ""
        if has_penalty(row, shift_group):
            c = Back.RED
        return c + str(val).center(width) + Style.RESET_ALL

    # Make the right table of the number of assgned shifts
    col_headers = list(table.df_shifts.columns)
    col_width = list(map(len, col_headers))
    col_width = list(map(lambda n: max(2, n), col_width))
    right_width = sum(col_width) + len(col_headers)
    data_rows = table.df_shifts.values.tolist()
    right_table = [col_headers] + data_rows
    right_table = [
        [format_right_cell(value, row_idx, col_headers[col_idx], col_width[col_idx]) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(right_table)
    ]

    def format_bottom_cell(val, idx, day):
        c = ""
        if has_penalty(idx, day):
            c = Back.RED
        return c + str(val).center(2) + Style.RESET_ALL

    # Make the bottom table of the number of assgned staffs
    idx_headers = list(table.df_staffs.index)
    idx_width = [max(len(tup[i]) for tup in idx_headers) for i in range(3)]
    botom_idx_width = sum(idx_width) + len(idx_width) - 1
    botom_padding = main_padding = 0
    if botom_idx_width < 25:   # 25 = 2 + 2 + 7 * 3
        botom_padding = 25 - botom_idx_width
    else:
        main_padding = botom_idx_width - 25
    bottom_table = table.df_staffs.values.tolist()
    bottom_table = [
        [format_bottom_cell(value, idx_headers[row_idx], col_idx) for col_idx, value in enumerate(row)]
        for row_idx, row in enumerate(bottom_table)
    ]

    if table.title:
        print(table.title)
    hrule = "-" * (main_padding + 3 * (table.width + 14 + 4) + right_width) # 14 days and 3 separators
    for idx, row in enumerate(main_table):
        # Main table
        if idx == 3:
            print(hrule)
        line = ' ' * main_padding
        line += row[0] + " | "
        line += ' '.join(row[1:8]) + " | "
        line += ' '.join(row[8:table.width + 8]) + " | "
        line += ' '.join(row[table.width + 8:]) + " | "
        # Right table
        if 1 == idx:
            line += '# assigned shifts'.center(right_width)
        elif 2 <= idx:
            line += ' '.join(right_table[idx - 2])
        print(line)
    print(hrule)
    # Bottom table
    for idx, row in enumerate(bottom_table):
        line = ' ' * botom_padding
        header = idx_headers[idx]
        header = [header[i].ljust(idx_width[i]) for i in range(3)]
        header = ' '.join(header)
        line += header + " | "
        line += ' '.join(row) + " |"
        print(line)

    # Penalties
    if len(table.penalties) > 0:
        for p in table.penalties:
            c = p['Cause']
            args = c.arguments
            if c.match("pos_request", 2):
                staff = args[0].number
                date = args[1].number
                p['Req'] = ','.join(table.request_map[staff][date]['pos']['Shift'])
                p['Res'] = table.assigned_map[staff][date]
            elif c.match("forbidden_pattern", 3):
                p['Req'] = p['Res'] = args[2].string


        pf = pd.DataFrame(table.penalties)
        pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)

        pf.index += 1
        print("Penalties:")
        print(pf[['P', 'W', 'Type', 'Cause', 'Req', 'Res']].to_string())
    else:
        print("Penalties:")
        print("  None")
    print()

def read_model(file):
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
    if table:
        print_shift_table(table)
    else:
        print(f"Error: file '{file}' contains no shift assignments (ext_assigned/3).")


def monitor_file(file, interval):
    """Monitor the file for changes and reload when updated."""
    last_modified = None
    while True:
        try:
            current_modified = os.path.getmtime(file)
            if current_modified != last_modified:
                last_modified = current_modified
                read_model(file)
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
    parser = argparse.ArgumentParser(description="Read a model from a file and display the shift table.")
    parser.add_argument("file", nargs="?", default="found-model.lp", help="Model file to read. Defaults to 'found-model.lp'.")
    parser.add_argument("--mono", action="store_true", help="Display output in monochrome (no colors).")
    parser.add_argument("-f", "--follow", type=float, nargs="?", const=1.0, help="Monitor the file for changes and reload when updated. Specify interval in seconds (default: 1 second).")

    args = parser.parse_args()

    colorama.init(strip=args.mono)

    if args.follow:
        monitor_file(args.file, interval=args.follow)
    else:
        read_model(args.file)

if __name__ == "__main__":
    main()