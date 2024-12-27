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
class STable:
    def __init__(self, title: str, main_df: pd.DataFrame, right_df: pd.DataFrame, bottom_df: pd.DataFrame, penalties, penalty_map, request_map):
        self.title = title
        self.main_df = main_df
        self.right_df = right_df
        self.bottom_df = bottom_df
        self.penalties = penalties
        self.penalty_map = penalty_map
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
            style = Fore.BLUE if dw == 'Sa' else Fore.RED if dw == 'Su' else None
            border = True if rd == -1 or rd == width - 1 or rd == width + 6 else False
            self.cells['ADay' ][rd] = Cell(str(ad), style=style, right_border=border)
            self.cells['Dweek'][rd] = Cell(str(dw), style=style, right_border=border)
            self.cells['RDay' ][rd] = Cell(str(rd), style=style, right_border=border)

        self.cells['TopBorder'] = {'index': Border()}

        # ------------------------------------------------------------
        # Make the main table
        for no, row in self.main_df.iterrows():
            style = Back.RED if self.has_penalty(no, 'index') else None
            self.cells[no] = {'index': Cell(str(no), style=style, right_border=True)}
            row = row.droplevel(["Month", "ADay", "Dweek"])
            for rd, s in row.items():
                border = True if rd == -1 or rd == width - 1 or rd == width + 6 else False
                style = SHIFT_COLOR[s]
                if self.has_request(no, rd):
                    style = Fore.BLACK + Back.GREEN
                if self.has_penalty(no, rd):
                    style = Back.RED
                self.cells[no][rd] = Cell(s, style=style, right_border=border)

        self.cells['BottomBorder'] = {'index': Border()}

        # ------------------------------------------------------------
        # Make the right table
        col_counts = self.right_df.columns.get_level_values(0).value_counts()
        print(col_counts)
        for t, c in col_counts.items():
            self.cells['Dweek'][t] = Cell(t, right_border=True, col_span=c)
        borders = col_counts.cumsum().tolist()
        for idx, col in enumerate(self.right_df.columns):
            t = col[1]
            border = True if idx+1 in borders else False
            self.cells['RDay'][t] = Cell(t, right_border=border)

        for no, row in self.right_df.iterrows():
            row = row.droplevel(0)
            for idx, (t, n) in enumerate(row.items()):
                border = True if idx+1 in borders else False
                style = None
                if self.has_penalty(no, t):
                    style = Back.RED
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
                    style = Back.RED
                self.cells[idx][rd] = Cell(str(n), style=style, right_border=border)

        self.max_width = sum(map(lambda e: e.width, self.cells['RDay'].values())) + len(self.cells['RDay'].values())

    def has_penalty(self, row, col):
        if row in self.penalty_map:
            return col in self.penalty_map[row]
        return False

    def has_request(self, row, col):
        if row in self.request_map:
            return col in self.request_map[row]
        return False

    def display(self):
        print(self.title)
        for row in self.cells:
            if isinstance(self.cells[row]['index'], Cell):
                print(''.join(map(lambda c: c.to_s(), self.cells[row].values())))
            else:
                print('-' * self.max_width)

        # Penalties
        if len(self.penalties) > 0:
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

            pf = pd.DataFrame(self.penalties)
            pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)
            pf.index += 1
            print("Penalties:")
            print(pf[['P', 'W', 'Type', 'Cause', 'Req', 'Res']].to_string())
        else:
            print("Penalties:")
            print("  None")
        print()

# class ShiftTable:
#     def __init__(self, df, title, first_date, width, df_shifts, df_staffs, penalties, penalty_map, assigned_map, request_map):
#         self.df = df
#         self.title = title
#         self.first_date = first_date
#         self.width = width
#         self.df_shifts = df_shifts
#         self.df_staffs = df_staffs
#         self.penalties = penalties
#         self.penalty_map = penalty_map
#         self.assigned_map = assigned_map
#         self.request_map = request_map

# class Penalty:
#     def __init__(self, type, cause, location, request, result, wegiht, priority):
#         self.type = type
#         self.cause = cause
#         self.location = location
#         self.request = request
#         self.result = result
#         self.weight = wegiht
#         self.priority = priority

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
    'penalty': [('Type', 'sym'), ('Cause', 'sym'), ('Req', 'num'), ('Res', 'num'), ('P', 'num'), ('W', 'num')],
    'pos_request': [('No', 'num'), ('Date', 'num'), ('Shift', 'str')],
    'neg_request': [('No', 'num'), ('Date', 'num'), ('Shift', 'str')],
    'horizontal_constraint_type': ['str'],
    'vertical_constraint_type': [('StaffGroup', 'str'), ('ShiftGroup', 'str'), ('ObjType', 'str')],
    'num_weekend_offs': [('No', 'num'), ('P', 'num'), ('C', 'num'), ('T', 'num')],
}

CAUSE_RULES = {
    'work_days_lb':   { 'target': 'staff', 'args': ['num'] },
    'work_days_ub':   { 'target': 'staff', 'args': ['num'] },
    'weekly_rest_lb': { 'target': 'staff', 'args': ['num'] },
    'weekly_rest_ub': { 'target': 'staff', 'args': ['num'] },

    'shift_lb': { 'target': 'shifts', 'args': ['num', 'str'] },
    'shift_ub': { 'target': 'shifts', 'args': ['num', 'str'] },

    'staff_lb': { 'target': 'staffs', 'args': ['str', 'str', 'num'] },
    'staff_ub': { 'target': 'staffs', 'args': ['str', 'str', 'num'] },

    'consecutive_work_days': { 'target': 'staff-day', 'args': ['num', 'num'] },
    'pos_request':           { 'target': 'staff-day', 'args': ['num', 'num'] },
    'neg_request':           { 'target': 'staff-day', 'args': ['num', 'num'] },
    'forbidden_pattern':     { 'target': 'staff-day', 'args': ['num', 'num'] },
    'next_shift':            { 'target': 'staff-day', 'args': ['num', 'num'] },
    'prev_shift':            { 'target': 'staff-day', 'args': ['num', 'num'] },

    'recommended_night_pair': { 'target': 'staff-pair', 'args': ['num', 'num'] },

    'forbidden_night_pair':   { 'target': 'staff-pair-day', 'args': ['num', 'num', 'num'] },
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

    # # 祝日休暇数を追加
    # if 'num_national_holiday_offs' in statistics:
    #     sdf = pd.DataFrame(statistics['num_national_holiday_offs'])
    #     sdf = sdf.set_index('staff')
    #     sdf.columns = pd.MultiIndex.from_product([['祝日休暇数'], ['過去', '当月', '合計']])
    #     #print(sdf)
    #     df_shifts = pd.concat([df_shifts, sdf], axis=1)
    #     #print(df_shifts)

    # # 連続休暇数を追加
    # if 'num_consecutive_holidays' in statistics:
    #     sdf = pd.DataFrame(statistics['num_consecutive_holidays'])
    #     sdf = sdf.set_index('staff')
    #     #print(sdf)
    #     sdf.columns = pd.MultiIndex.from_product([['連続休暇数'], ['過去', '当月', '合計']])
    #     #print(sdf)
    #     df_shifts = pd.concat([df_shifts, sdf], axis=1)
    #     #print(df_shifts)

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
    penalty_map = make_penalty_map_v2(model['penalty'])
    # for key, val in penalty_map.items():
    #     print(f'{key} = {val}')

    # ------------------------------------------------------------
    # Make the request mapping for the explanation of penalties
    request_map = recursive_defaultdict()
    for r in model['pos_request']:
        request_map[r["No"]][r["Date"]]['pos'].setdefault("Shift", []).append(r["Shift"])
    for r in model['neg_request']:
        request_map[r["No"]][r["Date"]]['neg'].setdefault("Shift", []).append(r["Shift"])

    title = None
    if 'header' in model:
        title = model['header'][0]

    return STable(title, main_df, right_df, bottom_df, model['penalty'], penalty_map, request_map)

def make_penalty_map_v2(penalties):
    pmap = {}
    def add(row, col, p):
        if row not in pmap:
            pmap[row] = {}
        if col not in pmap[row]:
            pmap[row][col] = []
        pmap[row][col].append(p)
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
            add(args[0], 'index', p)
        elif cause_rule['target'] == 'shifts':
            add(args[0], args[1], p)
        elif cause_rule['target'] == 'staffs':
            add((args[0], args[1], '#S'), args[2], p)
        elif cause_rule['target'] == 'staff-day':
            print(f'pmap[{args[0]}][{args[1]}] += {p}')
            add(args[0], args[1], p)
        elif cause_rule['target'] == 'staff-pair':
            add(args[0], 'index', p)
            add(args[1], 'index', p)
        elif cause_rule['target'] == 'staff-pair-day':
            add(args[0], args[2], p)
            add(args[1], args[2], p)
        else:
            raise ValueError(f'Unknown cause target: {cause_rule['target']}')

    return pmap


# def make_shift_table(atoms):
#     make_shift_table_v2(atoms)
#     header = None
#     first_date = None
#     width = None
#     assigneds = []
#     dates = []
#     staffs = []
#     staff_groups = []
#     penalties = []
#     requests = []
#     htypes = []
#     vtypes = []
#     for atom in atoms:
#         args = atom.arguments
#         if atom.match("header", 1):
#             header = args[0].string
#         elif atom.match("first_full_date", 1):
#             first_date = datetime.strptime(str(args[0].number), "%Y%m%d")
#         elif atom.match("table_width", 1):
#             width = args[0].number
#         elif atom.match("ext_assigned", 3):
#             assigneds.append({'No': args[0].number, 'Date': args[1].number, 'Shift': args[2].string})
#         elif atom.match("out_date", 3):
#             r_day = args[0].number
#             a_day = args[1].number % 100
#             dweek = args[2].string
#             dates.append((r_day, a_day, dweek))
#         elif atom.match("staff", 5):
#             staffs.append({'No': args[0].number, 'Name': args[1].string, 'Job': args[2].string, 'ID': args[3].string, 'Point': args[4].number})
#         elif atom.match("staff_group", 2):
#             gname = args[0].string
#             staff = args[1].number
#             staff_groups.append({'StaffGroup': gname, 'No': staff})
#         elif atom.match("penalty", 6):
#             ctype = args[0]
#             cause = args[1]
#             req   = args[2].number
#             res   = args[3].number
#             w     = args[4].number
#             p     = args[5].number
#             penalties.append({
#                 'Type': ctype,
#                 'Cause': cause,
#                 'Req': req,
#                 'Res': res,
#                 'P': p,
#                 'W': w,
#             })
#         elif atom.match("pos_request", 3):
#             requests.append({'Type': 'pos', 'No': args[0].number, 'Date': args[1].number, 'Shift': args[2].string})
#         elif atom.match("neg_request", 3):
#             requests.append({'Type': 'neg', 'No': args[0].number, 'Date': args[1].number, 'Shift': args[2].string})
#         elif atom.match("horizontal_constraint_type", 1):
#             shift_group  = args[0].string
#             htypes.append(shift_group)
#         elif atom.match("vertical_constraint_type", 3):
#             staff_group = args[0].string
#             shift_group = args[1].string
#             obj_type = args[2].string
#             vtypes.append({'StaffGroup': staff_group, 'ShiftGroup': shift_group, 'ObjType': obj_type})

#     if len(assigneds) == 0:
#         return None

#     # Shift assignments
#     df = pd.DataFrame(assigneds)

#     # Checking duplicated entries
#     duplicates = df[df.duplicated(subset=['No', 'Date'], keep=False)]
#     if not duplicates.empty:
#         print("=== Error: Duplicate Entries Detected ===")
#         print(duplicates)
#         print("=========================================")

#     # ------------------------------------------------------------
#     # Make the shift table
#     df_tbl = df.pivot(index='No', columns='Date', values='Shift')

#     # Add dates header to the shift table
#     dates = sorted(dates)
#     # Add missing dates
#     for date in dates:
#         if not date[0] in df_tbl.columns:
#             df_tbl[date[0]] = None
#     df_tbl = df_tbl.sort_index(axis='columns')
#     df_tbl.columns = pd.MultiIndex.from_tuples(dates)

#     # print(df_tbl)
#     # self.print_shift_table(df_tbl)

#     # ------------------------------------------------------------
#     # Make the table of the number of assigned shifts (horizontal)
#     cur_df = df[(0 <= df['Date']) & (df['Date'] <= width)]  # current month
#     # print("1"); print(cur_df)
#     # Extend the dataframe to count the number of assigned shift groups
#     shift_groups = [sg for sg in htypes if '+' in sg]
#     for shift_group in shift_groups:
#         for shift in shift_group.split("+"):
#             tmp_df = cur_df[cur_df['Shift'] == shift].copy()
#             tmp_df['Shift'] = shift_group
#             cur_df = pd.concat([cur_df, tmp_df])
#     # print("(2)"); print(cur_df)
#     gdf = cur_df.groupby(['No', 'Shift']).count().reset_index() # Count assigned shift groups
#     gdf = gdf.pivot(index='No', columns='Shift', values='Date') # Convert to the table
#     gdf = gdf.reindex(columns=htypes) # Change the column order
#     gdf = gdf.fillna(0).astype(int) # Convert to int
#     #print(gdf)
#     df_shifts = gdf

#     # ------------------------------------------------------------
#     # Make the table of the number of assigned staffs (vertical)
#     gdf = pd.DataFrame(staff_groups)
#     #print(gdf)
#     # Add staff group to df
#     mdf = pd.merge(cur_df, gdf, on='No', how='outer')
#     # print(mdf)
#     # Add staff point to df
#     sdf = pd.DataFrame(staffs)
#     sdf = sdf[["No", "Point"]]
#     mdf = pd.merge(mdf, sdf, on='No', how='outer')
#     # print(mdf)
#     # Extend the dataframe to count the number of assigned shift groups
#     shift_groups = [vtype['ShiftGroup'] for vtype in vtypes if '+' in vtype['ShiftGroup']]
#     shift_groups = list(dict.fromkeys(shift_groups))
#     for shift_group in shift_groups:
#         for shift in shift_group.split("+"):
#             tmp_df = mdf[mdf['Shift'] == shift].copy()
#             tmp_df['Shift'] = shift_group
#             mdf = pd.concat([mdf, tmp_df])
#     #print(mdf)
#     mdf = mdf.groupby(['Date', 'StaffGroup', 'Shift']).agg({'Shift': 'count', 'Point': 'sum'})
#     mdf = mdf.rename(columns={'Shift': 'Staffs', 'Point': 'Points'})
#     mdf = mdf.stack().unstack('Date')
#     #print(mdf)
#     # Remove unconstrained rows
#     idx = [(vtype['StaffGroup'], vtype['ShiftGroup'], vtype['ObjType']) for vtype in vtypes]
#     mdf = mdf.reindex(idx)
#     mdf = mdf.fillna(0).astype(int)  # Convert to int
#     # Add days if not exist
#     for date in range(0, width):
#         if not (date in mdf.columns):
#             mdf[date] = 0
#     mdf = mdf.sort_index(axis='columns')
#     df_staffs = mdf.rename(index={'Staffs': '#S', 'Points': '#P'})

#     # ------------------------------------------------------------
#     # Make the penalty mapping
#     penalty_map = make_penalty_map(penalties)
#     #print(f'penalty_map = {penalty_map}')

#     # ------------------------------------------------------------
#     # Make the assignment mapping for the explanation of penalties
#     assigned_map = recursive_defaultdict()
#     for a in assigneds:
#         assigned_map[a["No"]][a["Date"]] = a["Shift"]

#     # ------------------------------------------------------------
#     # Make the request mapping for the explanation of penalties
#     request_map = recursive_defaultdict()
#     for r in requests:
#         request_map[r["No"]][r["Date"]][r["Type"]].setdefault("Shift", []).append(r["Shift"])

#     return ShiftTable(df_tbl, header, first_date, width, df_shifts, df_staffs, penalties, penalty_map, assigned_map, request_map)

# def make_penalty_map(penalties):
#     map = {}
#     def add(row, col, p):
#         if row not in map:
#             map[row] = {}
#         if col not in map[row]:
#             map[row][col] = []
#         map[row][col].append(p)

#     staff_day_causes = [
#         ("consecutive_work_days", 2),
#         ("pos_request", 2),
#         ("neg_request", 2),
#         ("forbidden_pattern", 3),
#         ("next_shift", 3),
#         ("prev_shift", 3),
#     ]
#     for p in penalties:
#         cause = p['Cause']
#         args = cause.arguments
#         if cause.match("work_days_lb", 1) or cause.match("work_days_ub", 1) or cause.match("weekly_rest_lb", 1) or cause.match("weekly_rest_ub", 1) or cause.match("pattern_lb", 2) or cause.match("pattern_ub", 2):
#             staff = args[0].number
#             add(staff, -8, p)
#         elif cause.match("shift_lb", 2) or cause.match("shift_ub", 2):
#             staff = args[0].number
#             shift_group = args[1].string
#             add(staff, shift_group, p)
#         elif cause.match("staff_lb", 3) or cause.match("staff_ub", 3):
#             staff_group = args[0].string
#             shift_group = args[1].string
#             day = args[2].number
#             row = (staff_group, shift_group, "#S")
#             add(row, day, p)
#         elif any(cause.match(name, args) for name, args in staff_day_causes):
#             staff = args[0].number
#             day = args[1].number
#             add(staff, day, p)
#         elif cause.match("recommended_night_pair", 2):
#             staff1 = args[0].number
#             staff2 = args[1].number
#             add(staff1, -8, p)
#             add(staff2, -8, p)
#         elif cause.match("forbidden_night_pair", 3):
#             staff1 = args[0].number
#             staff2 = args[1].number
#             day = args[2].number
#             add(staff1, day, p)
#             add(staff2, day, p)
#         else:
#             raise ValueError(f'Unknown penalty cause: {cause}')

#     return map

# def print_shift_table(table):

#     def has_request(row, col):
#         if row in table.request_map:
#             return col in table.request_map[row]
#         return False

#     def has_penalty(row, col):
#         if row in table.penalty_map:
#             return col in table.penalty_map[row]
#         return False

#     def format_main_cell(val, row, col):
#         w = col_headers[2][col]
#         c = ""
#         if row < 3:
#             if w == "Sa":
#                 c = Fore.BLUE
#             elif w == "Su" or w == "PH":
#                 c = Fore.RED
#         elif col > 0:
#             if val == "D":
#                 c = Fore.GREEN
#             elif val == "LD" or val == "SE" or val == "SN":
#                 c = Fore.CYAN
#             elif val == "E" or val == "N":
#                 c = Fore.BLUE
#             elif val == "EM" or val == "LM":
#                 c = Fore.YELLOW
#             elif val == "WR" or val == "PH":
#                 c = Style.DIM
#             else:
#                 c = Fore.MAGENTA
#         if has_request(row - 2, col - 8):
#             c = Fore.BLACK + Back.GREEN
#         if has_penalty(row - 2, col - 8):
#             c = Back.RED
#         return c + str(val).center(2) + Style.RESET_ALL

#     df = table.df.fillna("  ")
#     col_headers = [[""] + list(col) for col in zip(*df.columns.tolist())]
#     data_rows = [[index] + row.tolist() for index, row in zip(df.index, df.values)]
#     main_table = col_headers + data_rows

#     # Formatting cells
#     main_table = [
#         [format_main_cell(value, row_idx, col_idx) for col_idx, value in enumerate(row)]
#         for row_idx, row in enumerate(main_table)
#     ]
#     # Add the current month
#     if table.first_date:
#         month = (table.first_date - timedelta(days=7)).month
#         main_table[1][0] = ["Ja", "Fe", "Ma", "Ap", "My", "Ju", "Jl", "Au", "Se", "Oc", "No", "De"][month-1]

#     def format_right_cell(val, row, shift_group, width):
#         c = ""
#         if has_penalty(row, shift_group):
#             c = Back.RED
#         return c + str(val).center(width) + Style.RESET_ALL

#     # Make the right table of the number of assgned shifts
#     col_headers = list(table.df_shifts.columns)
#     col_width = list(map(len, col_headers))
#     col_width = list(map(lambda n: max(2, n), col_width))
#     right_width = sum(col_width) + len(col_headers)
#     data_rows = table.df_shifts.values.tolist()
#     right_table = [col_headers] + data_rows
#     right_table = [
#         [format_right_cell(value, row_idx, col_headers[col_idx], col_width[col_idx]) for col_idx, value in enumerate(row)]
#         for row_idx, row in enumerate(right_table)
#     ]

#     def format_bottom_cell(val, idx, day):
#         c = ""
#         if has_penalty(idx, day):
#             c = Back.RED
#         return c + str(val).center(2) + Style.RESET_ALL

#     # Make the bottom table of the number of assgned staffs
#     idx_headers = list(table.df_staffs.index)
#     idx_width = [max(len(tup[i]) for tup in idx_headers) for i in range(3)]
#     botom_idx_width = sum(idx_width) + len(idx_width) - 1
#     botom_padding = main_padding = 0
#     if botom_idx_width < 25:   # 25 = 2 + 2 + 7 * 3
#         botom_padding = 25 - botom_idx_width
#     else:
#         main_padding = botom_idx_width - 25
#     bottom_table = table.df_staffs.values.tolist()
#     bottom_table = [
#         [format_bottom_cell(value, idx_headers[row_idx], col_idx) for col_idx, value in enumerate(row)]
#         for row_idx, row in enumerate(bottom_table)
#     ]

#     if table.title:
#         print(table.title)
#     hrule = "-" * (main_padding + 3 * (table.width + 14 + 4) + right_width) # 14 days and 3 separators
#     for idx, row in enumerate(main_table):
#         # Main table
#         if idx == 3:
#             print(hrule)
#         line = ' ' * main_padding
#         line += row[0] + " | "
#         line += ' '.join(row[1:8]) + " | "
#         line += ' '.join(row[8:table.width + 8]) + " | "
#         line += ' '.join(row[table.width + 8:]) + " | "
#         # Right table
#         if 1 == idx:
#             line += '# assigned shifts'.center(right_width)
#         elif 2 <= idx:
#             line += ' '.join(right_table[idx - 2])
#         print(line)
#     print(hrule)
#     # Bottom table
#     for idx, row in enumerate(bottom_table):
#         line = ' ' * botom_padding
#         header = idx_headers[idx]
#         header = [header[i].ljust(idx_width[i]) for i in range(3)]
#         header = ' '.join(header)
#         line += header + " | "
#         line += ' '.join(row) + " |"
#         print(line)

#     # Penalties
#     if len(table.penalties) > 0:
#         for p in table.penalties:
#             c = p['Cause']
#             args = c.arguments
#             if c.match("pos_request", 2):
#                 staff = args[0].number
#                 date = args[1].number
#                 p['Req'] = ','.join(table.request_map[staff][date]['pos']['Shift'])
#                 p['Res'] = table.assigned_map[staff][date]
#             elif c.match("forbidden_pattern", 3):
#                 p['Req'] = p['Res'] = args[2].string
#             elif c.match("forbidden_night_pair", 3):
#                 staff1 = args[0].number
#                 staff2 = args[1].number
#                 date = args[2].number
#                 p['Req'] = table.assigned_map[staff1][date]
#                 p['Res'] = table.assigned_map[staff2][date]

#         pf = pd.DataFrame(table.penalties)
#         pf = pf.sort_values(['P', 'W', 'Type', 'Cause'], ascending=[False, False, True, True], ignore_index=True)

#         pf.index += 1
#         print("Penalties:")
#         print(pf[['P', 'W', 'Type', 'Cause', 'Req', 'Res']].to_string())
#     else:
#         print("Penalties:")
#         print("  None")
#     print()

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