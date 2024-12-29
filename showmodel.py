#!/usr/bin/env python3
import argparse
from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime, timedelta
import fcntl
import os
import re
import sys
import time
import clingo
from colorama import Back, Fore, Style
import colorama
import pandas as pd

@dataclass
class Cell:
    text: str = ""
    width: int = 2
    align: str = 'center'
    style: str = None
    right_border: bool = False
    col_span: int = 1

    def to_s(self) -> str:
        # Apply alignment
        w = self.width
        if self.col_span > 1:
            w += (self.width + 1) * (self.col_span - 1)
        if self.text:
            if self.align == 'center':
                formatted_text = self.text[:w].center(w)
            elif self.align == 'right':
                formatted_text = self.text[:w].rjust(w)
            elif self.align == 'left':
                formatted_text = self.text[:w].ljust(w)
        else:
            formatted_text = " " * w

        # Apply style (color and text attributes)
        if self.style:
            formatted_text = self.style + formatted_text + Style.RESET_ALL

        # Add the right border if specified
        if self.right_border:
            formatted_text += "|"
        else:
            formatted_text += " "

        return formatted_text

@dataclass
class Border:
    width: int = 0

    def to_s(self) -> str:
        return "-" * self.width

SHIFT_COLOR = {
    "D":  Fore.GREEN,
    "LD": Fore.CYAN,
    "SE": Fore.CYAN,
    "SN": Fore.CYAN,
    "E":  Fore.BLUE,
    "N":  Fore.BLUE,
    "EM": Fore.YELLOW,
    "LM": Fore.YELLOW,
    "WR": Style.DIM,
    "PH": Style.DIM,
    "BT": Fore.MAGENTA,
    "TR": Fore.MAGENTA,
    "HC": Fore.MAGENTA,
    "AL": Fore.MAGENTA,
    "BL": Fore.MAGENTA,
    "HL": Fore.MAGENTA,
    "ML": Fore.MAGENTA,
    "NL": Fore.MAGENTA,
    "PL": Fore.MAGENTA,
    "SL": Fore.MAGENTA,
    "SP": Fore.MAGENTA,
    "VL": Fore.MAGENTA,
    "WL": Fore.MAGENTA,
    '': Fore.BLACK,
}

@dataclass
class ShiftTable:
    def __init__(self, title: str, main_df: pd.DataFrame, right_df: pd.DataFrame, bottom_df: pd.DataFrame, penalties, rewards, penalty_map, reward_map, request_map):
        self.title = title
        self.main_df = main_df
        self.right_df = right_df
        self.bottom_df = bottom_df
        self.penalties = penalties
        self.rewards = rewards
        self.penalty_map = penalty_map
        self.reward_map = reward_map
        self.request_map = request_map
        self.cells = {}

        # ------------------------------------------------------------
        # Make the column header
        #print(self.main_df.columns)
        month_counts = self.main_df.columns.get_level_values("Month").value_counts().sort_index()
        #print(month_counts)
        self.cells['Month'] = {'index': Cell(right_border=True)}
        for m, c in month_counts.items():
            self.cells['Month'][m] = Cell(str(m), right_border=True, col_span=c)
        self.cells['ADay']  = {'index': Cell(right_border=True)}
        self.cells['Dweek'] = {'index': Cell(right_border=True)}
        self.cells['RDay']  = {'index': Cell(right_border=True)}
        width = len(self.main_df.columns) - 14
        for col in self.main_df.columns:
            ad = col[1]
            dw = col[2]
            rd = col[3]
            style = Fore.BLUE if dw == 'Sa' else Fore.RED if dw == 'Su' or dw == 'PH' else None
            border = True if rd == -1 or rd == width - 1 or rd == width + 6 else False
            self.cells['ADay' ][rd] = Cell(str(ad), style=style, right_border=border)
            self.cells['Dweek'][rd] = Cell(str(dw), style=style, right_border=border)
            self.cells['RDay' ][rd] = Cell(str(rd), style=style, right_border=border)

        self.cells['TopBorder'] = {'index': Border()}

        # ------------------------------------------------------------
        # Make the main table
        for no, row in self.main_df.iterrows():
            style = Fore.BLACK + Back.RED if self.has_penalty(no, 'index') else None
            self.cells[no] = {'index': Cell(str(no), style=style, right_border=True)}
            row = row.droplevel(["Month", "ADay", "Dweek"])
            for rd, s in row.items():
                border = True if rd == -1 or rd == width - 1 or rd == width + 6 else False
                style = SHIFT_COLOR[s]
                if self.has_request(no, rd):
                    style = Fore.BLACK + Back.GREEN
                if self.has_penalty(no, rd):
                    style = Fore.BLACK + Back.RED
                self.cells[no][rd] = Cell(s, style=style, right_border=border)

        self.cells['BottomBorder'] = {'index': Border()}

        # ------------------------------------------------------------
        # Make the right table
        col_counts = self.right_df.columns.get_level_values(0).value_counts()
        # print(col_counts)
        for t, c in col_counts.items():
            self.cells['Dweek'][t] = Cell(t, right_border=True, col_span=c)
        borders = col_counts.cumsum().tolist()
        for idx, col in enumerate(self.right_df.columns):
            t = col[1]
            border = True if idx+1 in borders else False
            self.cells['RDay'][col] = Cell(t, right_border=border)

        for no, row in self.right_df.iterrows():
            # row = row.droplevel(0)
            for idx, (t, n) in enumerate(row.items()):
                # print(f't={t}, n={n}')
                border = True if idx+1 in borders else False
                style = None
                if self.has_reward(no, t):
                    style = Fore.BLACK + Back.CYAN
                if self.has_penalty(no, t):
                    style = Fore.BLACK + Back.RED
                self.cells[no][t] = Cell(str(n), style=style, right_border=border)

        # ------------------------------------------------------------
        # Make the bottom table
        idx_widths = [max(len(str(item)) for item in self.bottom_df.index.get_level_values(i)) for i in range(len(self.bottom_df.index.levels))]
        idx_strings = [" ".join(f'{str(item):<{idx_widths[i]}}' for i, item in enumerate(tpl)) for tpl in self.bottom_df.index]
        for i, (idx, row) in enumerate(self.bottom_df.iterrows()):
            self.cells[idx] = {'index': Cell(idx_strings[i], col_span=8, align='right', right_border=True)}

        for idx, row in self.bottom_df.iterrows():
            for rd, n in row.items():
                border = True if rd == width - 1 else False
                style = None
                if self.has_penalty(idx, rd):
                    style = Fore.BLACK + Back.RED
                self.cells[idx][rd] = Cell(str(n), style=style, right_border=border)

        max_width = sum(map(lambda e: e.width, self.cells['RDay'].values())) + len(self.cells['RDay'].values())
        self.cells['TopBorder']['index'].width = max_width
        self.cells['BottomBorder']['index'].width = max_width

    def has_penalty(self, row, col):
        if row in self.penalty_map:
            return col in self.penalty_map[row]
        return False

    def has_reward(self, row, col):
        if row in self.reward_map:
            return col in self.reward_map[row]
        return False

    def has_request(self, row, col):
        if row in self.request_map:
            return col in self.request_map[row]
        return False

    def display(self):
        if self.title:
            print(self.title)
        for row in self.cells:
            print(''.join(map(lambda c: c.to_s(), self.cells[row].values())))

        # Penalties
        if len(self.penalties) > 0:
            # Complement the explanations
            for p in self.penalties:
                c = p['Cause']
                args = c.arguments
                if c.match("pos_request", 2):
                    staff = args[0].number
                    date = args[1].number
                    p['Req'] = ','.join(self.request_map[staff][date]['pos']['Shift'])
                    p['Res'] = self.cells[staff][date].text
                elif c.match("forbidden_pattern", 3):
                    p['Req'] = p['Res'] = args[2].string
                elif c.match("forbidden_night_pair", 3):
                    staff1 = args[0].number
                    staff2 = args[1].number
                    date = args[2].number
                    p['Req'] = self.cells[staff1][date].text
                    p['Res'] = self.cells[staff2][date].text
                elif c.match("adjacent_rest_days", 2):
                    p['Req'] = p['Res'] = '-'

            penalties = self.penalties
            for r in self.rewards:
                r['W'] = -r['W']
                r['Type'] = 'reward'
                r['Req'] = r['Res'] = '-'
            pf = pd.DataFrame(self.penalties + self.rewards)
            pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)
            pf.index += 1
            print("Penalties:")
            print(pf[['P', 'W', 'Type', 'Cause', 'Req', 'Res']].to_string())
        else:
            print("Penalties:")
            print("  None")
        print()

# Create a recursive defaultdict
def recursive_defaultdict():
    return defaultdict(recursive_defaultdict)

ATOM_RULES = {
    'header': ['str'],
    'first_full_date': ['num'],
    'table_width': ['num'],
    'ext_assigned': [('No', 'num'), ('Date', 'num'), ('Shift', 'str')],
    'out_date': [('RDay', 'num'), ('ADay', 'num'), ('Dweek', 'str')],
    'staff': [('No', 'num'), ('Name', 'str'), ('Job', 'str'), ('ID', 'str'), ('Point', 'num')],
    'staff_group': [('StaffGroup', 'str'), ('No', 'num')],
    'penalty': [('Type', 'sym'), ('Cause', 'sym'), ('Req', 'num'), ('Res', 'num'), ('W', 'num'), ('P', 'num') ],
    'reward': [('Cause', 'sym'), ('W', 'num'), ('P', 'num') ],
    'pos_request': [('No', 'num'), ('Date', 'num'), ('Shift', 'str')],
    'neg_request': [('No', 'num'), ('Date', 'num'), ('Shift', 'str')],
    'horizontal_constraint_type': ['str'],
    'vertical_constraint_type': [('StaffGroup', 'str'), ('ShiftGroup', 'str'), ('ObjType', 'str')],
    'num_weekend_offs': [('No', 'num'), ('P', 'num'), ('C', 'num'), ('T', 'num')],
    'num_public_holiday_offs': [('No', 'num'), ('P', 'num'), ('C', 'num'), ('T', 'num')],
    'num_consecutive_rests': [('No', 'num'), ('P', 'num'), ('C', 'num'), ('T', 'num')],
}

CAUSE_RULES = {
    'work_days_lb':   { 'target': 'staff', 'args': ['num'] },
    'work_days_ub':   { 'target': 'staff', 'args': ['num'] },
    'weekly_rest_lb': { 'target': 'staff', 'args': ['num'] },
    'weekly_rest_ub': { 'target': 'staff', 'args': ['num'] },
    'eq_shifts':      { 'target': 'staff', 'args': ['num'] },
    'pattern_lb':     { 'target': 'staff', 'args': ['num', 'str'] },
    'pattern_ub':     { 'target': 'staff', 'args': ['num', 'str'] },

    'shift_lb': { 'target': 'shifts', 'args': ['num', 'str'] },
    'shift_ub': { 'target': 'shifts', 'args': ['num', 'str'] },

    'staff_lb': { 'target': 'staffs', 'args': ['str', 'str', 'num'] },
    'staff_ub': { 'target': 'staffs', 'args': ['str', 'str', 'num'] },

    'point_lb': { 'target': 'points', 'args': ['str', 'str', 'num'] },
    'point_ub': { 'target': 'points', 'args': ['str', 'str', 'num'] },

    'consecutive_work_days': { 'target': 'staff-day', 'args': ['num', 'num'] },
    'pos_request':           { 'target': 'staff-day', 'args': ['num', 'num'] },
    'neg_request':           { 'target': 'staff-day', 'args': ['num', 'num'] },
    'forbidden_pattern':     { 'target': 'staff-day', 'args': ['num', 'num'] },
    'next_shift':            { 'target': 'staff-day', 'args': ['num', 'num'] },
    'prev_shift':            { 'target': 'staff-day', 'args': ['num', 'num'] },
    'isolated_work_day':     { 'target': 'staff-day', 'args': ['num', 'num'] },
    'adjacent_rest_days':    { 'target': 'staff-day', 'args': ['num', 'num'] },

    'recommended_night_pair': { 'target': 'staff-pair', 'args': ['num', 'num'] },

    'forbidden_night_pair':   { 'target': 'staff-pair-day', 'args': ['num', 'num', 'num'] },

    'weekend_offs':        { 'target': '#wkndOffs', 'args': ['num'] },
    'public_holiday_offs': { 'target': '#phOffs',   'args': ['num'] },
    'consecutive_rests':   { 'target': '#cnscOffs', 'args': ['num'] },
}

def conv_symbol(sym: clingo.Symbol, type: str):
    # print(f"conv_symobl({sym}, {type})")
    if type == 'num':
        return sym.number
    if type == 'str':
        return sym.string
    if type == 'sym':
        return sym
    raise ValueError(f'Unexpected type: {type} for {sym}')

def make_shift_table(atoms: list[clingo.Symbol]):
    # ------------------------------------------------------------
    # Parse atoms
    model = {}
    for atom in atoms:
        if atom.name not in ATOM_RULES:
            continue
        # print(atom)
        parse_rule = ATOM_RULES[atom.name]
        if atom.name not in model:
            model[atom.name] = []
        if len(parse_rule) == 1:
            arg = atom.arguments[0]
            arg = conv_symbol(arg, parse_rule[0])
            model[atom.name].append(arg)
        elif len(atom.arguments) == len(parse_rule):
            args = {}
            for idx, arg in enumerate(atom.arguments):
                name, type = parse_rule[idx]
                args[name] = conv_symbol(arg, type)
            model[atom.name].append(args)

    if 'ext_assigned' not in model:
        return None

    # ------------------------------------------------------------
    # Make the main shift table

    # Shift assignments
    df = pd.DataFrame(model['ext_assigned'])

    # Checking duplicated entries
    duplicates = df[df.duplicated(subset=['No', 'Date'], keep=False)]
    if not duplicates.empty:
        print("=== Error: Duplicate Entries Detected ===")
        print(duplicates)
        print("=========================================")

    # Make the two-dimentional shift table
    main_df = df.pivot(index='No', columns='Date', values='Shift')

    # Complement missing dates
    dates = sorted(model['out_date'], key=lambda d: d['RDay'])
    for date in dates:
        if not date['RDay'] in main_df.columns:
            main_df[date['RDay']] = None
    main_df.sort_index(axis='columns', inplace=True)

    # Add dates header for columns
    first_date = datetime.strptime(str(model['first_full_date'][0]), "%Y%m%d")
    dates = [{'Month': (first_date + timedelta(days=d['RDay'])).month, 'ADay': d['ADay'] % 100, 'Dweek': d['Dweek'], 'RDay': d['RDay'] } for d in dates]
    #print(dates)
    main_df.columns = pd.MultiIndex.from_frame(pd.DataFrame(dates))
    main_df.fillna("", inplace=True)
    #print(df_tbl)

    # ------------------------------------------------------------
    # Make the right table to display the number of assigned shifts
    cur_df = df[(0 <= df['Date']) & (df['Date'] <= model['table_width'][0])]  # current month
    # Extend the dataframe to count the number of assigned shift groups
    shift_groups = [sg for sg in model['horizontal_constraint_type'] if '+' in sg]
    for shift_group in shift_groups:
        for shift in shift_group.split("+"):
            tmp_df = cur_df[cur_df['Shift'] == shift].copy()
            tmp_df['Shift'] = shift_group
            cur_df = pd.concat([cur_df, tmp_df])
    right_df = cur_df.groupby(['No', 'Shift']).count().reset_index() # Count assigned shift groups
    right_df = right_df.pivot(index='No', columns='Shift', values='Date') # Convert to the table
    right_df = right_df.reindex(columns=model['horizontal_constraint_type']) # Change the column order
    right_df = right_df.fillna(0).astype(int) # Convert to int
    right_df.columns = pd.MultiIndex.from_product([['#shifts'], list(right_df.columns)])
    #print(right_df)

    # Add the number of weekend offs if exists
    if 'num_weekend_offs' in model:
        sdf = pd.DataFrame(model['num_weekend_offs'])
        sdf = sdf.set_index('No')
        sdf.columns = pd.MultiIndex.from_product([['#wkndOffs'], list(sdf.columns)])
        right_df = pd.concat([right_df, sdf], axis=1)
        #print(right_df)

    # Add the number of public holiday offs if exists
    if 'num_public_holiday_offs' in model:
        sdf = pd.DataFrame(model['num_public_holiday_offs'])
        sdf = sdf.set_index('No')
        sdf.columns = pd.MultiIndex.from_product([['#phOffs'], list(sdf.columns)])
        right_df = pd.concat([right_df, sdf], axis=1)
        #print(right_df)

    # Add the number of consecutive rests if exists
    if 'num_consecutive_rests' in model:
        sdf = pd.DataFrame(model['num_consecutive_rests'])
        sdf = sdf.set_index('No')
        sdf.columns = pd.MultiIndex.from_product([['#cnscOffs'], list(sdf.columns)])
        right_df = pd.concat([right_df, sdf], axis=1)
        #print(right_df)

    # # 火曜NJ数を追加
    # if 'num_tue_nj_shifts' in statistics:
    #     sdf = pd.DataFrame(statistics['num_tue_nj_shifts'])
    #     sdf = sdf.set_index('staff')
    #     sdf.columns = pd.MultiIndex.from_product([['火曜NJ数'], ['過去', '当月', '合計']])
    #     #print(sdf)
    #     df_shifts = pd.concat([df_shifts, sdf], axis=1)
    #     #print(df_shifts)

    # ------------------------------------------------------------
    # Make the bottom table to display the number of assigned staffs (vertical)
    gdf = pd.DataFrame(model['staff_group'])
    #print(gdf)
    # Add staff group to df
    mdf = pd.merge(cur_df, gdf, on='No', how='outer')
    # print(mdf)
    # Add staff point to df
    sdf = pd.DataFrame(model['staff'])[["No", "Point"]]
    mdf = pd.merge(mdf, sdf, on='No', how='outer')
    # print(mdf)
    # Extend the dataframe to count the number of assigned shift groups
    shift_groups = [vtype['ShiftGroup'] for vtype in model['vertical_constraint_type'] if '+' in vtype['ShiftGroup']]
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
    idx = [(vtype['StaffGroup'], vtype['ShiftGroup'], vtype['ObjType']) for vtype in model['vertical_constraint_type']]
    mdf = mdf.reindex(idx)
    mdf = mdf.fillna(0).astype(int)  # Convert to int
    # Add days if not exist
    for date in range(0, model['table_width'][0]):
        if not (date in mdf.columns):
            mdf[date] = 0
    mdf = mdf.sort_index(axis='columns')
    bottom_df = mdf.rename(index={'Staffs': '#S', 'Points': '#P'})
    #print(bottom_df)

    # ------------------------------------------------------------
    # Make the penalty mapping
    penalty_map = make_penalty_map(model['penalty'])
    # for key, val in penalty_map.items():
    #     print(f'{key} = {val}')

    # ------------------------------------------------------------
    # Make the reward mapping
    reward_map = make_reward_map(model['reward'])
    # for key, val in reward_map.items():
    #     print(f'{key} = {val}')

    # ------------------------------------------------------------
    # Make the request mapping for the explanation of penalties
    request_map = recursive_defaultdict()
    if 'pos_request' in model:
        for r in model['pos_request']:
            request_map[r["No"]][r["Date"]]['pos'].setdefault("Shift", []).append(r["Shift"])
    if 'neg_request' in model:
        for r in model['neg_request']:
            request_map[r["No"]][r["Date"]]['neg'].setdefault("Shift", []).append(r["Shift"])

    title = None
    if 'header' in model:
        title = model['header'][0]

    return ShiftTable(title, main_df, right_df, bottom_df, model['penalty'], model['reward'], penalty_map, reward_map, request_map)

def add(pmap, row, col, p):
    if row not in pmap:
        pmap[row] = {}
    if col not in pmap[row]:
        pmap[row][col] = []
    pmap[row][col].append(p)

def make_penalty_map(penalties):
    pmap = {}
    for p in penalties:
        cause = p['Cause']
        if cause.name not in CAUSE_RULES:
            raise ValueError(f'Unknown penalty cause: {cause}')
        cause_rule = CAUSE_RULES[cause.name]
        args = []
        for idx, type in enumerate(cause_rule['args']):
            arg = cause.arguments[idx]
            args.append(conv_symbol(arg, type))
        if cause_rule['target'] == 'staff':
            add(pmap, args[0], 'index', p)
        elif cause_rule['target'] == 'shifts':
            add(pmap, args[0], ('#shifts', args[1]), p)
        elif cause_rule['target'] == 'staffs':
            add(pmap, (args[0], args[1], '#S'), args[2], p)
        elif cause_rule['target'] == 'points':
            add(pmap, (args[0], args[1], '#P'), args[2], p)
        elif cause_rule['target'] == 'staff-day':
            add(pmap, args[0], args[1], p)
        elif cause_rule['target'] == 'staff-pair':
            add(pmap, args[0], 'index', p)
            add(pmap, args[1], 'index', p)
        elif cause_rule['target'] == 'staff-pair-day':
            add(pmap, args[0], args[2], p)
            add(pmap, args[1], args[2], p)
        else:
            raise ValueError(f'Unknown cause target: {cause_rule['target']}')

    return pmap

def make_reward_map(rewards):
    rmap = {}
    for r in rewards:
        cause = r['Cause']
        if cause.name not in CAUSE_RULES:
            raise ValueError(f'Unknown reward cause: {cause}')
        cause_rule = CAUSE_RULES[cause.name]
        args = []
        for idx, type in enumerate(cause_rule['args']):
            arg = cause.arguments[idx]
            args.append(conv_symbol(arg, type))
        target = cause_rule['target']
        if target in ['#wkndOffs', '#phOffs', '#cnscOffs']:
            add(rmap, args[0], (target, 'C'), r)
        else:
            raise ValueError(f'Unknown cause target: {target}')

    return rmap

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

    lines = content.split("\n")
    facts = []
    # If it's the output from clingo, display the last model
    if lines[0].startswith("clingo version"):
        last_index = next((i for i in reversed(range(len(lines))) if lines[i].startswith("Answer:")), -1)
        if last_index == -1 or len(lines) <= last_index + 1:
            print(f"Error: file '{file}' contains no model.")
            return

        # replace spaces inside double quotes with a underscore (is there a better way?)
        facts = re.sub(r'"[^"]*"', lambda m: m.group(0).replace(' ', '_'), lines[last_index+1])
        facts = facts.split(" ")
        header = lines[last_index]
        if last_index + 2 < len(lines) and lines[last_index+2].startswith("Optimization:"):
            header += ", " + lines[last_index+2]
        facts = [f'header("{header}")'] + facts
    # Otherwise, display the found model by nspsolver.py
    else:
        facts = [fact.rstrip(".") for fact in lines]

    atoms = parse_model(facts)
    table = make_shift_table(atoms)
    if table:
        table.display()
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

def parse_model(facts):
    atoms = []
    try:
        for fact in facts:
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