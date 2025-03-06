#!/usr/bin/env python3

import argparse
import datetime
import fcntl
import sys

import clingo
import jpholiday

def read_model(file: str):
    try:
        with open(file, 'r') as f:
            fcntl.flock(f, fcntl.LOCK_SH)
            try:
                content = f.read()
                atoms = parse_model(content)
            finally:
                fcntl.flock(f, fcntl.LOCK_UN)
    except FileNotFoundError:
        print(f"Error: File '{file}' not found.")
        sys.exit(1)
    return atoms

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

def generate_past_shift_data(model):
    width = None
    assigneds = []
    staffs = {}
    dates = {}
    for atom in model:
        args = atom.arguments
        if atom.match("table_width", 1):
            width = args[0].number
        elif atom.match("ext_assigned", 3):
            staff = args[0].number
            date  = args[1].number
            s     = args[2].string
            assigneds.append({'No': staff, 'Date': date, 'Shift': s})
        elif atom.match("staff", 5):
            no   = args[0].number
            name = args[1].string
            id   = args[3].string
            staffs[no] = {'Name': name, 'ID': id}
        elif atom.match("base_date", 3):
            r_day = args[0].number
            a_day = args[1].number
            dates[r_day] = a_day

    assigneds = [ a for a in assigneds if 0 <= a['Date'] and a['Date'] < width ]
    assigneds = sorted(assigneds, key=lambda e: (e["Date"], e["No"], e["Shift"]))

    print("% Past shift assignments -------------------------")
    used_dates = set()
    for assigned in assigneds:
        no = assigned['No']
        rday = assigned['Date']
        shift = assigned['Shift']
        name = staffs[no]['Name']
        id = staffs[no]['ID']
        date = dates[rday]
        used_dates.add(date)
        print(f'shift_data("{id}", "{name}", {date}, "{shift}").')

    print("% Past dates -------------------------------------")
    used_dates = sorted(list(used_dates))
    for int_date in used_dates:
        date = datetime.datetime.strptime(str(int_date), "%Y%m%d")
        print(f'past_date({int_date}, "{get_wday(date)}").')

    print("% Past public holidays")
    for int_date in used_dates:
        date = datetime.datetime.strptime(str(int_date), "%Y%m%d")
        if jpholiday.is_holiday(date):
            print(f'past_public_holiday({int_date}, "{get_wday(date)}").')

def get_wday(date):
    return ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"][date.weekday()]

def main():
    parser = argparse.ArgumentParser(description="Read a model from a file or standard input.")
    parser.add_argument("file", nargs="?", default="found-model.lp", help="Model file to read (default: 'found-model.lp').")

    args = parser.parse_args()

    model = read_model(args.file)
    generate_past_shift_data(model)

if __name__ == "__main__":
    main()