#!/usr/bin/env python3
import argparse
import re
import sys
from typing import List, Union

from clingo import Symbol
from showmodel import parse_model, read_model

class AssignmentRectangle:
    """Class representing a 2D rectangle for shift assignments"""
    def __init__(self, nurse_range=(None, None), day_range=(None, None)):
        """
        Initialize an AssignmentRectangle with day and nurse ranges.
        If a range is unspecified, (None, None) is used to indicate "all-inclusive".
        """
        self.start_nurse, self.end_nurse = nurse_range
        self.start_day, self.end_day = day_range

    def contains(self, nurse, day):
        """Check if (day, nurse) falls within this rectangle"""
        nurse_match = (self.start_nurse is None or self.start_nurse <= nurse <= self.end_nurse)
        day_match = (self.start_day is None or self.start_day <= day <= self.end_day)
        #print(f"contains({nurse}, {day}) = {day_match} and {nurse_match}")
        return day_match and nurse_match

    def __repr__(self):
        nurse_range = f"n{self.start_nurse}-{self.end_nurse}" if self.start_nurse is not None else "all_nurses"
        day_range = f"d{self.start_day}-{self.end_day}" if self.start_day is not None else "all_days"
        return f"Rect({nurse_range}, {day_range})"

def parse_rectangles(option_list):
    """Parses the list of -c or -f options and creates a list of rectangles"""
    rectangles = []

    if option_list:
        for option_str in option_list:
            days_list = []
            nurses_list = []

            # Use regex to correctly extract dX-Y and nA-B patterns
            day_matches = re.findall(r'd[\d,-]+', option_str)
            nurse_matches = re.findall(r'n[\d,-]+', option_str)

            # Extract days and nurses separately
            for match in day_matches:
                days_list.extend(expand_range(match[1:]))  # Remove 'd' prefix

            for match in nurse_matches:
                nurses_list.extend(expand_range(match[1:]))  # Remove 'n' prefix

            # Default to all-inclusive if not explicitly mentioned
            if not days_list:
                days_list = [(None, None)]
            if not nurses_list:
                nurses_list = [(None, None)]

            # Create assignment rectangles
            for day_range in days_list:
                for nurse_range in nurses_list:
                    #print(f"day_range = {day_range}, nurse_range = {nurse_range}")
                    rectangles.append(AssignmentRectangle(nurse_range, day_range))

    return rectangles


def expand_range(range_str):
    """Expands a range (e.g., 2-5, 10,12) into a list of range tuples"""
    ranges = []
    parts = [p.strip() for p in range_str.split(",") if p.strip()]
    for part in parts:
        part = part.strip()
        if "-" in part:
            try:
                start, end = map(int, part.split("-"))
                ranges.append((start, end))
            except ValueError:
                print(f"Warning: Invalid range '{part}', skipping.", file=sys.stderr)
        else:
            try:
                value = int(part)
                ranges.append((value, value))
            except ValueError:
                print(f"Warning: Invalid number '{part}' in '{parts}', skipping.", file=sys.stderr)
    return ranges

def should_process(assigned, rectangles):
    """Checks if the given assigned atom falls within any of the specified rectangles"""
    args = assigned.arguments
    if len(args) >= 2:
        nurse, day = args[0].number, args[1].number
        for rect in rectangles:
            if rect.contains(nurse, day):
                return True
    return False

def make_legacy_model(in_data: Union[str, List[str]], fixed_rects, clear_rects, out_file: str = None):
    soften_hard = False
    table_width = 28
    if isinstance(in_data, str):
        atoms = read_model(in_data)
    else:
        atoms = parse_model(in_data)
    atoms.sort()
    for atom in atoms:
        if atom.match("soften_hard", 0):
            soften_hard = True
        elif atom.match("table_width", 1):
            table_width = atom.arguments[0].number
    fixed_atoms = []
    for atom in atoms:
        if atom.match("ext_assigned", 3) and should_process(atom, fixed_rects):
            fixed_atoms.append(atom)
    prioritized_atoms = []
    for atom in atoms:
        if atom.match("ext_assigned", 3) and not should_process(atom, clear_rects) and not should_process(atom, fixed_rects):
            day = atom.arguments[1].number
            if 0 <= day < table_width:
                prioritized_atoms.append(atom)
    if out_file:
        with open(out_file, 'w') as out:
            # output fixed/1 for all ext_assigned/3 atoms that are fixed
            for atom in fixed_atoms:
                print(f"fixed({atom}).", file=out)
            # output prioritized/1 for all ext_assigned/3 atoms that are prioritized
            for atom in prioritized_atoms:
                print(f"prioritized({atom}).", file=out)

    return (soften_hard, fixed_atoms, prioritized_atoms)

def main():
    parser = argparse.ArgumentParser(description="reads a model file, extracts shift assignments, and outputs them in legacy format.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("file", nargs="?", default="found-model.lp", help="Model file to read")
    parser.add_argument("-o", "--output", type=str, default="legacy-model.lp", help="Output file for models")
    parser.add_argument("-c", "--clear", type=str, action="append", default=[],
                        help="Clear specific assignments (e.g., '-c d2-5,n3-6')")
    parser.add_argument("-f", "--fixed", type=str, action="append", default=[],
                        help="Fix specific assignments (e.g., '-f d1-3,n2-4')")

    args = parser.parse_args()

    fixed_rectangles = parse_rectangles(args.fixed)
    clear_rectangles = parse_rectangles(args.clear)
    # print(f"fixed: {fixed_rectangles}")
    # print(f"clear: {clear_rectangles}")
    make_legacy_model(args.file, fixed_rectangles, clear_rectangles, args.output)

if __name__ == "__main__":
    main()