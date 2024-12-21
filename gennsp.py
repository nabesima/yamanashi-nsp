#!/usr/bin/env python3
import argparse
from dataclasses import dataclass, field
import datetime
import random
from sys import stdout
from typing import List
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
            print(f'staff_group("{self.name}", {staff.no}).')

@dataclass
class Dates:
    str_start_date: str
    width: int

    def __post_init__(self):
        self.start_date = datetime.datetime.strptime(self.str_start_date, "%Y-%m-%d")

    def to_asp(self, out):

        def get_wday(date):
            return ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"][date.weekday()]

        print("% Dates ------------------------------------------", file=out)
        for d in list(range(-7, self.width + 7)):
            date = self.start_date + datetime.timedelta(days=d)
            int_date = date.strftime("%Y%m%d")
            print(f'base_date({d}, {int_date}, "{get_wday(date)}").', file=out)

        print("% Previous month", file=out)
        for d in list(range(-7, 0)):
            date = self.start_date + datetime.timedelta(days=d)
            print(f'prev_date({d}, "{get_wday(date)}").', file=out)

        print("% This month", file=out)
        for d in list(range(0, self.width)):
            date = self.start_date + datetime.timedelta(days=d)
            print(f'date({d}, "{get_wday(date)}").', file=out)

        print("% Next month", file=out)
        for d in list(range(self.width, self.width + 7)):
            date = self.start_date + datetime.timedelta(days=d)
            print(f'next_date({d}, "{get_wday(date)}").', file=out)

        print("% Public holidays", file=out)
        for d in list(range(-7, self.width + 7)):  
            date = self.start_date + datetime.timedelta(days=d)
            if jpholiday.is_holiday(date):
                print(f'public_holiday({d}).', file=out)

        print("% Past dates -------------------------------------", file=out)
        for d in list(range(-7-28, -7)):
            date = self.start_date + datetime.timedelta(days=d)
            int_date = date.strftime("%Y%m%d")
            print(f'past_date({d}, {int_date}, "{get_wday(date)}").', file=out)

        print("% Past public holidays", file=out)
        for d in list(range(-7-28, -7)):
            date = self.start_date + datetime.timedelta(days=d)
            if jpholiday.is_holiday(date):
                int_date = date.strftime("%Y%m%d")
                print(f'past_public_holiday({d}, {int_date}, "{get_wday(date)}").', file=out)

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

    def set_default_setting(self, num_staffs:int, num_days: int, start_date: str):
        self.set_width(num_days, start_date)
        self.set_default_staffs(num_staffs)
        self.set_default_shifts_constraint()
        self.set_default_staffs_constraints()

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

def main():
    parser = argparse.ArgumentParser(description="Generate a Nurse Scheduling Problem instance.")
    parser.add_argument("-n", type=int, default=6, help="Number of nurses (default: 6)")
    parser.add_argument("-d", type=int, default=7, help="Number of days (default: 7)")
    parser.add_argument("-s", type=str, default="2025-04-01", help="Start date in YYYY-MM-DD format (default: 2025-04-01)")
    parser.add_argument("-r", type=int, default=None, help="Set the random seed (default: None)")
    args = parser.parse_args()

    if args.r != None:
        fake.seed_instance(args.r)
        random.seed(args.r)

    # Generate a NSP instance
    nsp_instance = NSP()
    nsp_instance.set_default_setting(args.n, args.d, args.s)
    nsp_instance.to_asp(stdout)

if __name__ == "__main__":
    main()
