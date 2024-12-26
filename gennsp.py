#!/usr/bin/env python3
import argparse
from dataclasses import dataclass, field
from datetime import datetime, timedelta
import random
from sys import stdout
from typing import List, Union
from faker import Faker
import jpholiday
from defparams import DEF_STAFF_BOUNDS

fake = Faker()

@dataclass
class Staff:
    no: int
    name: str
    job: str
    id: str
    point: int

    def to_asp(self, out):
        print(f'staff({self.no}, "{self.name}", "{self.job}", "{self.id}", {self.point}).', file=out)

@dataclass
class StaffGroup:
    name: str
    members: List[Staff] = field(default_factory=list)

    def add(self, staff):
        self.members.append(staff)

    def to_asp(self, out):
        print(f'staff_group("{self.name}").', file=out)
        for staff in self.members:
            print(f'staff_group("{self.name}", {staff.no}).', file=out)

@dataclass
class Dates:
    str_start_date: str
    width: int

    def __post_init__(self):
        self.start_date = datetime.strptime(self.str_start_date, "%Y-%m-%d")

    def get(self, d: int) -> datetime:
        return self.start_date + timedelta(days=d)

    def is_holiday(self, d: Union[int, datetime]):
        if isinstance(d, int):
            date = self.start_date + timedelta(days=d)
        elif isinstance(d, datetime):
            date = d
        return jpholiday.is_holiday(date)

    def to_asp(self, out):

        def get_wday(date):
            return ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"][date.weekday()]

        print("% Dates ------------------------------------------", file=out)
        for d in list(range(-7, self.width + 7)):
            date = self.start_date + timedelta(days=d)
            int_date = date.strftime("%Y%m%d")
            print(f'base_date({d}, {int_date}, "{get_wday(date)}").', file=out)

        print("% Previous month", file=out)
        for d in list(range(-7, 0)):
            date = self.start_date + timedelta(days=d)
            print(f'prev_date({d}, "{get_wday(date)}").', file=out)

        print("% This month", file=out)
        for d in list(range(0, self.width)):
            date = self.start_date + timedelta(days=d)
            print(f'date({d}, "{get_wday(date)}").', file=out)

        print("% Next month", file=out)
        for d in list(range(self.width, self.width + 7)):
            date = self.start_date + timedelta(days=d)
            print(f'next_date({d}, "{get_wday(date)}").', file=out)

        print("% Public holidays", file=out)
        for d in list(range(-7, self.width + 7)):
            if self.is_holiday(d):
                print(f'public_holiday({d}).', file=out)

@dataclass
class ShiftGroup:
    name: str
    shifts: list[str]

    def to_asp(self, out):
        print(f'shift_group("{self.name}").', file=out)
        for shift in self.shifts:
            print(f'shift_group("{self.name}", "{shift}").', file=out)

@dataclass
class ShiftBound:
    btype: str
    staff: int
    shift_group: ShiftGroup
    val: int

    def __post_init__(self):
        if self.btype != "soft_lb" and self.btype != "soft_ub" and self.btype != "hard_lb" and self.btype != "hard_ub":
            raise ValueError(f'Unexpected shift bound type: {self.btype}')

    def to_asp(self, out):
        print(f'shifts_{self.btype}({self.staff}, "{self.shift_group.name}", {self.val}).', file=out)

@dataclass
class StaffBound:
    btype: str
    staff_group: StaffGroup
    shift_group: ShiftGroup
    dweek_type: str
    val: int

    def __post_init__(self):
        if self.btype != "soft_lb" and self.btype != "soft_ub" and self.btype != "hard_lb" and self.btype != "hard_ub":
            raise ValueError(f'Unexpected staff bound type: {self.btype}')
        if self.dweek_type != "Weekday" and self.dweek_type != "Weekend" and self.dweek_type != "Holiday":
            raise ValueError(f'Unexpected dweek type: {self.dweek_type}')

    def to_asp(self, out):
        print(f'staff_dweek_{self.btype}("{self.staff_group.name}", "{self.shift_group.name}", "{self.dweek_type}", {self.val}).', file=out)

@dataclass
class HorizontalConstraintType:
    shift_group: ShiftGroup

    def to_asp(self, out):
        print(f'horizontal_constraint_type("{self.shift_group.name}").', file=out)

@dataclass
class VerticalConstraintType:
    staff_group: StaffGroup
    shift_group: ShiftGroup
    obj_type: str

    def __post_init__(self):
        if self.obj_type != "Staffs" and self.obj_type != "Points":
            raise ValueError(f'Unexpected object type: {self.obj_type}')

    def to_asp(self, out):
        print(f'vertical_constraint_type("{self.staff_group.name}", "{self.shift_group.name}", "{self.obj_type}").', file=out)

SHIFTS = {
    "work": [ "D", "LD", "EM", "LM", "E", "SE", "N", "SN"] ,
    "rest": [ "WR", "PH" ],
    "business": [ "BT", "TR", "HC" ],
    "leave": [ "AL", "BL", "HL", "ML", "NL", "PL", "SL", "SP", "VL", "WL" ],
    "na": [ "AB", "LA", "NA" ],
}

@dataclass
class StaffRequest:
    pos: bool
    staff: Staff
    start_date: datetime
    date: datetime
    shift: str

    def is_conflict(self, other):
        if self.staff == other.staff and self.date == other.date:
            if self.pos != other.pos:
                return self.shift == other.shift  # requesting the same shift as both positive and negative
            if self.shift == other.shift:
                return True  # avoid the same request
            # business, leave or na shifts can be requested only once for the same day.
            if self.shift in SHIFTS["business"] or self.shift in SHIFTS["leave"] or self.shift in SHIFTS["na"]:
                return True
        return False

    def to_string(self):
        pos = "pos" if self.pos else "neg"
        diff = self.date - self.start_date
        return f'staff_{pos}_request({self.staff.no}, {diff.days}, "{self.shift}").'

    def to_asp(self, out):
        print(self.to_string(), file=out)

@dataclass
class StaffDefRequest:
    pos: bool
    staff: Staff
    dweek: str
    shift: str

    def is_conflict(self, other):
        if self.staff == other.staff and self.dweek == other.dweek:
            if self.pos != other.pos:
                return self.shift == other.shift  # requesting the same shift as both positive and negative
            if self.shift == other.shift:
                return True  # avoid the same request
        return False

    def to_string(self):
        pos = "pos" if self.pos else "neg"
        return f'staff_def_{pos}_request_dweek({self.staff.no}, "{self.dweek}", "{self.shift}").'

    def to_asp(self, out):
        print(self.to_string(), file=out)

@dataclass
class Pattern:
    shifts: list[str]

    def __post_init__(self):
        self.name = "-".join(self.shifts)

    def to_asp(self, out):
        print(f'pattern("{self.name}", {len(self.shifts)}).', file=out)
        for idx, shift in enumerate(self.shifts):
            print(f'pattern("{self.name}", {idx}, "{shift}").', file=out)

@dataclass
class PatternBound:
    btype: str
    pattern: Pattern
    val: int

    def __post_init__(self):
        if self.btype != "soft_lb" and self.btype != "soft_ub" and self.btype != "hard_lb" and self.btype != "hard_ub":
            raise ValueError(f'Unexpected staff bound type: {self.btype}')

    def to_asp(self, out):
        print(f'pattern_{self.btype}("{self.pattern.name}", {self.val}).', file=out)

@dataclass
class ForbiddenPattern:
    pattern: Pattern

    def to_asp(self, out):
        print(f'forbidden_pattern("{self.pattern.name}").', file=out)

@dataclass
class PrevShift:
    base: str
    prev: str

    def to_asp(self, out):
        print(f'prev_shift("{self.base}", "{self.prev}").', file=out)

@dataclass
class NextShift:
    base: str
    next: str

    def to_asp(self, out):
        print(f'next_shift("{self.base}", "{self.next}").', file=out)

@dataclass
class RecommendedPair:
    mentor: Staff
    novice: Staff
    lb: int

    def to_asp(self, out):
        print(f'recommended_night_pair({self.mentor.no}, {self.novice.no}, {self.lb}).', file=out)

@dataclass
class ForbiddenPair:
    n1: Staff
    n2: Staff

    def to_asp(self, out):
        print(f'forbidden_night_pair({self.n1.no}, {self.n2.no}).', file=out)

class NSP:
    def __init__(self):
        self.staffs = []
        self.used_ids = set()  # Keep track of used IDs
        self.staff_groups = {}
        self.shift_groups = {}
        self.dates = None
        self.shift_bounds = []
        self.staff_bounds = []
        self.horizontal_constraint_types = []
        self.vertical_constraint_types = []
        self.consecutive_work_days = None
        self.staff_requests = []
        self.staff_def_requests = []
        self.shift_patterns = []
        self.pattern_bounds = []
        self.forbidden_patterns = []
        self.prev_shifts = []
        self.next_shifts = []
        self.recommended_pairs = []
        self.forbidden_pairs = []

    def set_width(self, num_days: int, start_date: str = "2025-04-01"):
        self.dates = Dates(start_date, num_days)

    def add_staff(self, name: str, job: str, point: int, id: str = None) -> Staff:
        def generate_unique_id():
            while True:
                new_id = random.randint(10000, 99999)
                if new_id not in self.used_ids:
                    self.used_ids.add(new_id)
                    return new_id
        if id == None:
            id = generate_unique_id()
        else:
            if id in self.used_ids:
                raise ValueError(f'Duplicated ID: {id}')
            self.used_ids.add(id)
        no = len(self.staffs) + 1
        staff = Staff(no, name, job, id, point)
        self.staffs.append(staff)
        return staff

    def add_staff_group(self, name: str) -> StaffGroup:
        if name not in self.staff_groups:
            self.staff_groups[name] = StaffGroup(name)
        return self.staff_groups[name]

    def add_staff_to_group(self, group_name: str, staff: Staff):
        if group_name not in self.staff_groups:
            raise ValueError(f'Unknown staff group: {group_name}')
        self.staff_groups[group_name].members.append(staff)

    def add_shift_group(self, shifts: list[str]) -> ShiftGroup:
        name = "+".join(shifts)
        if name not in self.shift_groups:
            self.shift_groups[name] = ShiftGroup(name, shifts)
        return self.shift_groups[name]

    def add_shift_bound(self, type: str, staff: Staff, shifts: list[str], val):
        sg = self.add_shift_group(shifts)
        h = HorizontalConstraintType(sg)
        if h not in self.horizontal_constraint_types:
            self.horizontal_constraint_types.append(h)
        self.shift_bounds.append(ShiftBound(type, staff.no, sg, val))

    def add_staff_bound(self, btype: str, staff_group: StaffGroup, shifts: list[str], dweek_type: str, val: int):
        shift_group = self.add_shift_group(shifts)
        v = VerticalConstraintType(staff_group, shift_group, "Staffs")
        if v not in self.vertical_constraint_types:
            self.vertical_constraint_types.append(v)
        self.staff_bounds.append(StaffBound(btype, staff_group, shift_group, dweek_type, val))

    def add_staff_request(self, pos: bool, staff: Staff, date: datetime, shift: str):
        req = StaffRequest(pos, staff, self.dates.start_date, date, shift)
        for r in self.staff_requests:
            if req.is_conflict(r):
                #print("  conflict: " + r.to_string())
                return False
        self.staff_requests.append(req)
        return True

    def add_staff_def_request(self, pos: bool, staff: Staff, dweek: str, shift: str):
        req = StaffDefRequest(pos, staff, dweek, shift)
        for r in self.staff_def_requests:
            if req.is_conflict(r):
                #print("  conflict: " + r.to_string())
                return False
        self.staff_def_requests.append(req)
        return True

    def add_pattern_bound(self, btype: str, shifts: list[str], val: int):
        p = Pattern(shifts)
        if p not in self.shift_patterns:
            self.shift_patterns.append(p)
        if p not in self.pattern_bounds:
            self.pattern_bounds.append(PatternBound(btype, p, val))

    def add_forbidden_pattern(self, shifts: list[str]):
        p = Pattern(shifts)
        if p not in self.shift_patterns:
            self.shift_patterns.append(p)
        if p not in self.forbidden_patterns:
            self.forbidden_patterns.append(ForbiddenPattern(p))

    def add_prev_shifts(self, base:str, prevs: list[str]):
        for prev in prevs:
            self.prev_shifts.append(PrevShift(base, prev))

    def add_next_shifts(self, base:str, nexts: list[str]):
        for next in nexts:
            self.next_shifts.append(NextShift(base, next))

    def add_recommended_pair(self, mentor: Staff, novice: Staff, lb: int):
        self.recommended_pairs.append(RecommendedPair(mentor, novice, lb))

    def add_forbidden_pair(self, n1: Staff, n2: Staff):
        self.forbidden_pairs.append(ForbiddenPair(n1, n2))

    def set_default_setting(self, num_staffs:int = 6, num_days: int = 7, start_date: str = "2025-04-01", consec_work_days: int = 5, staff_req: float = 0.05, def_req_staffs: int = 0, recommended_pairs: int = 0, forbidden_pairs: int = 0):
        self.set_width(num_days, start_date)
        self.set_default_staffs(num_staffs)
        self.set_default_shifts_constraint()
        self.set_default_staffs_constraints()
        self.consecutive_work_days = consec_work_days
        self.set_default_staff_requests(staff_req, def_req_staffs)
        self.set_default_pattern_bounds()
        self.set_default_forbbiden_patterns()
        self.set_default_prev_next_shifts()
        self.set_default_recommended_pairs(recommended_pairs)
        self.set_default_forbidden_pairs(forbidden_pairs)

    def set_default_staffs(self, num):

        def split_with_rounding(num, ratios):
            counts = [round(num * r) for r in ratios]
            diff = num - sum(counts)
            for i in range(abs(diff)):
                counts[i % len(counts)] += 1 if diff > 0 else -1
            return counts

        counts = split_with_rounding(num, [0.3, 0.5, 0.2])

        self.add_staff_group("All")
        self.add_staff_group("Expert")
        self.add_staff_group("Medium")
        self.add_staff_group("Novice")

        for _ in range(counts[0]):
            name = fake.name()
            point = random.randint(7, 9)  # High skill level
            staff = self.add_staff(name, "Nurse", point)
            self.add_staff_to_group("Expert", staff)

        for _ in range(counts[1]):
            name = fake.name()
            point = random.randint(4, 6)  # Medium skill level
            staff = self.add_staff(name, "Nurse", point)
            self.add_staff_to_group("Medium", staff)

        for _ in range(counts[2]):
            name = fake.name()
            point = random.randint(1, 3)  # Low skill level
            staff = self.add_staff(name, "Nurse", point)
            self.add_staff_to_group("Novice", staff)

        for staff in self.staffs:
            self.add_staff_to_group("All", staff)

    def set_default_shifts_constraint(self, high_load_shift=2/7):
        base_ub = self.dates.width * high_load_shift
        base_lb = self.dates.width * high_load_shift / 2
        for key in self.staff_groups:
            group = self.staff_groups[key]
            if key == "All":
                continue
            elif key == "Expert" or key =="Medium":
                ub = round(base_ub)
                lb = round(base_lb)
            elif key == "Novice":
                ub = round(base_ub * 0.5)
                lb = round(base_lb * 0.5)
            else:
                raise ValueError(f"Unexpected staff group: {key}")
            for staff in group.members:
                # test
                #self.add_shift_bound("hard_lb", staff, ["D", "LD"], 0)
                for shift in ["LD", "SE", "SN"]:
                    self.add_shift_bound("soft_lb", staff, [shift], lb)
                    self.add_shift_bound("soft_ub", staff, [shift], ub)
                for shift in ["E", "N"]:
                    self.add_shift_bound("hard_ub", staff, [shift], 0)
                self.add_shift_bound("hard_ub", staff, ["EM"], 0)
                self.add_shift_bound("hard_ub", staff, ["LM"], 1)


    def set_default_staffs_constraints(self):
        for staff_gname in DEF_STAFF_BOUNDS:
            staff_group = self.staff_groups[staff_gname]
            for shift_gnames in DEF_STAFF_BOUNDS[staff_gname]:
                for shift_gname in shift_gnames.split(","):
                    shift_group = shift_gname.split("+")
                    for dweeks in DEF_STAFF_BOUNDS[staff_gname][shift_gnames]:
                        for dweek in dweeks.split(","):
                            for btype in DEF_STAFF_BOUNDS[staff_gname][shift_gnames][dweeks]:
                                val = DEF_STAFF_BOUNDS[staff_gname][shift_gnames][dweeks][btype]
                                num = round(val * len(staff_group.members))
                                if num == 0:
                                    continue
                                self.add_staff_bound(btype, staff_group, shift_group, dweek, num)

    def set_default_staff_requests(self, ratio, def_req_staffs):
        req_shifts = ["D", "SE", "SN", "WR", "BT", "TR", "AL", "BL"]
        num_cells = len(self.staffs) * self.dates.width
        num_req = round(num_cells * ratio)
        for _ in range(0, num_req):
            while True:
                staff = random.choice(self.staffs)
                date = self.dates.get(random.randint(0, self.dates.width + 7 - 1)) # Include the first week of the following month
                shift = random.choice(req_shifts)
                # Change WR to PH if the date is holiday
                if shift == "WR" and self.dates.is_holiday(date):
                    shift = "PH"
                # Handle short evening or short night shifts as negative requests
                pos = shift != "SE" and shift != "SN"
                if self.add_staff_request(pos, staff, date, shift):
                    break
        def_req_shifts = ["D", "LD", "SE", "SN"]
        for _ in range(0, def_req_staffs):
            while True:
                pos = random.choice([True, False])
                staff = random.choice(self.staffs)
                dweek = random.choice(["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su", "PH"])
                shift = random.choice(def_req_shifts)
                if self.add_staff_def_request(pos, staff, dweek, shift):
                    break

    def set_default_pattern_bounds(self):
        self.add_pattern_bound("hard_lb", ["WR", "WR"], 2)
        self.add_pattern_bound("soft_ub", ["LD", "D"],  1)
        self.add_pattern_bound("soft_ub", ["LM", "D"],  0)
        self.add_pattern_bound("soft_ub", ["LM", "LD"], 0)
        self.add_pattern_bound("soft_ub", ["LM", "LM"], 0)

    def set_default_forbbiden_patterns(self):
        self.add_forbidden_pattern(["LD", "LD"])
        self.add_forbidden_pattern(["SE" ,"SN", "SE", "SN"])
        self.add_forbidden_pattern(["LD", "D"])
        self.add_forbidden_pattern(["LM", "LD"])
        self.add_forbidden_pattern(["LM", "D"])

    def set_default_prev_next_shifts(self):
        # SE -> [SN] -> SE, WR
        self.add_prev_shifts("SN", ["SE"])
        self.add_next_shifts("SN", ["SE", "WR"])
        # LD, LM -> [SE] -> SN
        self.add_prev_shifts("SE", ["LD", "LM"])
        self.add_next_shifts("SE", ["SN"])
        # [E] -> N
        self.add_next_shifts("E", ["N"])
        # E -> [N] -> WR
        self.add_prev_shifts("N", ["E"])
        self.add_next_shifts("N", ["WR"])

    def set_default_recommended_pairs(self, num_pairs):
        mentors = self.staff_groups["Expert"].members + self.staff_groups["Medium"].members
        novices = self.staff_groups["Novice"].members
        for _ in range(0, num_pairs):
            # Select one expert or medium nurse and one novice nurse.
            mentor = random.choice(mentors)
            novice = random.choice(novices)
            num = round(self.dates.width / 7)
            self.add_recommended_pair(mentor, novice, num)

    def set_default_forbidden_pairs(self, num_pairs):
        for _ in range(0, num_pairs):
            ns = random.sample(self.staffs, 2)
            self.add_forbidden_pair(ns[0], ns[1])

    def to_asp(self, out):
        print("% Staffs -----------------------------------------", file=out)
        for staff in self.staffs:
            staff.to_asp(out)
        print("% Staff groups -----------------------------------", file=out)
        for key in self.staff_groups:
            self.staff_groups[key].to_asp(out)
        self.dates.to_asp(out)
        print("% Shift groups -----------------------------------", file=out)
        for key in self.shift_groups:
            self.shift_groups[key].to_asp(out)
        print("% Horizontal constraints -------------------------", file=out)
        for sb in self.shift_bounds:
            sb.to_asp(out)
        for h in self.horizontal_constraint_types:
            h.to_asp(out)
        print("% Vertical constraints ---------------------------", file=out)
        for sb in self.staff_bounds:
            sb.to_asp(out)
        for v in self.vertical_constraint_types:
            v.to_asp(out)
        print("% Shift related constraints ----------------------", file=out)
        if self.consecutive_work_days:
            print("% Maximum consecutive working days", file=out)
            print(f"consecutive_work_ub({self.consecutive_work_days}).", file=out)
        print("% Previous shifts", file=out)
        for p in self.prev_shifts:
            p.to_asp(out)
        print("% Next shifts", file=out)
        for n in self.next_shifts:
            n.to_asp(out)
        print("% Shift patterns", file=out)
        for p in self.shift_patterns:
            p.to_asp(out)
        print("% Pattern bounds", file=out)
        for p in self.pattern_bounds:
            p.to_asp(out)
        print("% Forbidden patterns", file=out)
        for p in self.forbidden_patterns:
            p.to_asp(out)
        print("% Staff requests ---------------------------------", file=out)
        for r in self.staff_requests:
            r.to_asp(out)
        for r in self.staff_def_requests:
            r.to_asp(out)
        print("% Pairs --------------------------------------", file=out)
        for p in self.recommended_pairs:
            p.to_asp(out)
        for p in self.forbidden_pairs:
            p.to_asp(out)


def main():
    parser = argparse.ArgumentParser(description="Generate a Nurse Scheduling Problem instance.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-n", "--num-nurses", type=int, default=6, help="Number of nurses")
    parser.add_argument("-d", "--num-days", type=int, default=7, help="Number of days")
    parser.add_argument("-s", "--start-date", type=str, default="2025-04-01", help="Start date in YYYY-MM-DD format")
    parser.add_argument("-c", "--consecutive-work-days", type=int, default=5, help="Number of consecutive workdays")
    parser.add_argument("-r", "--staff-request", type=float, default=0.05, help="Staff request rate as a percentage (between 0.0 and 1.0)")
    parser.add_argument("-dr", "--default-requests", type=int, default=0, help="Specify the number of default shift requests")
    parser.add_argument("-rp", "--recommended-pairs", type=int, default=0, help="Specify the number of recommended night shift pairs")
    parser.add_argument("-fp", "--forbidden-pairs", type=int, default=0, help="Specify the number of forbidden night shift pairs")
    parser.add_argument("--seed", type=int, default=None, help="Set the random seed")
    args = parser.parse_args()

    if args.seed != None:
        fake.seed_instance(args.seed)
        random.seed(args.seed)

    # Generate a NSP instance
    nsp_instance = NSP()
    nsp_instance.set_default_setting(
        args.num_nurses,
        args.num_days,
        args.start_date,
        args.consecutive_work_days,
        args.staff_request,
        args.default_requests,
        args.recommended_pairs,
        args.forbidden_pairs,
    )
    nsp_instance.to_asp(stdout)

if __name__ == "__main__":
    main()
