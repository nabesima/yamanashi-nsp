#!/usr/bin/env python3
import argparse
import random

def main():
    parser = argparse.ArgumentParser(description="Generate a Nurse Scheduling Problem instance.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-n", "--num-nurses", type=int, default=40, help="Number of nurses")
    parser.add_argument("-d", "--num-days", type=int, default=28, help="Number of days")
    parser.add_argument("-r", "--staff-request", type=int, default=10, help="Number of staff request")
    parser.add_argument("--seed", type=int, default=None, help="Set the random seed")
    args = parser.parse_args()

    if args.seed != None:
        random.seed(args.seed)

    req_shifts = ["D", "SE", "SN", "WR", "BT", "TR", "AL", "BL"]
    for _ in range(0, args.staff_request):
        staff = random.randrange(0, args.num_nurses) + 1
        date = int(args.num_days / 2) + random.randrange(0, int(args.num_days / 2))
        shift = random.choice(req_shifts)
        # Change WR to PH if the date is holiday
        if shift == "WR" and (date == 7 or date == 15):     # The 7th and 15th of September are public holidays in Japan
            shift = "PH"
        # Handle short evening or short night shifts as negative requests
        pos = shift != "SE" and shift != "SN"
        if pos:
            print(f'staff_pos_request({staff},{date},"{shift}").')
        else:
            print(f'staff_neg_request({staff},{date},"{shift}").')

if __name__ == "__main__":
    main()
