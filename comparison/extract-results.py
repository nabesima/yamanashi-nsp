#!/usr/bin/env python3
import argparse
import glob
import os
import re
import subprocess

def strip_ansi_codes(text):
    return re.sub(r'\x1b\[[0-9;]*m', '', text)

def extract_result(file, timeout=None):
    if not os.path.exists(file):
        return None

    try:
        results = subprocess.check_output(f'grep "Answer:" {file}', shell=True, text=True).strip()
        results = strip_ansi_codes(results)
    except subprocess.CalledProcessError:
        return None

    pattern = re.compile(r"Answer: (\d+), Cost: (.+), Elapsed: (\d+.\d+)s, #Changed: (\d+)")
    nearest_entry = None
    nearest_elapsed = float('-inf')

    for line in results.split("\n"):
        match = pattern.match(line)
        if match:
            no, costs, elapsed, changed = match.groups()
            no = int(no)
            costs = list(map(int, costs.split()))
            elapsed = float(elapsed)
            changed = int(changed)

            if timeout == None or (elapsed <= timeout and elapsed > nearest_elapsed):
                nearest_entry = {"no": no, "costs": costs, "time": elapsed, "changed": changed}
                nearest_elapsed = elapsed

    return nearest_entry

def main():
    parser = argparse.ArgumentParser(description="Extract results from log files")
    parser.add_argument("-l", "--log-dir", type=str, help="Path to the directory containing log files")
    parser.add_argument("-t", "--timeout", type=int, default=None, metavar="SECONDS", help="Time limit for solving (in seconds)")

    args = parser.parse_args()

    instances = sorted([os.path.basename(f)[:-3] for f in glob.glob("instances/nsp-*.lp")])
    log_dirs  = [(f"{args.log_dir}/lnps", 1)]
    log_dirs += [(f"{args.log_dir}/mp-p{i}",i) for i in range(1, 4)]
    log_dirs += [(f"{args.log_dir}/mp-ps-p{i}",i) for i in range(1, 4)]
    log_dirs += [(f"{args.log_dir}/mp-is-p{i}",i) for i in range(1, 4)]

    for instance in instances:
        #print(f"Instance: {instance}")

        results = {}
        for log_dir, priority in log_dirs:
            log_file = f"{log_dir}/{instance}.log"
            #print(f"log_file: {log_file}")
            results[log_dir] = extract_result(log_file, args.timeout)
            # print(f"{log_file}: {results[log_dir]}")
            if results[log_dir]:
                if priority == 1:
                    results[log_dir]['cost'] = results[log_dir]['costs'][0]
                elif priority == 2:
                    results[log_dir]['cost'] = results[log_dir]['costs'][0] - results[log_dir]['changed']
                elif priority == 3:
                    results[log_dir]['cost'] = results[log_dir]['costs'][1]

        if None in results.values():
            continue

        output_data = [instance]
        for log_dir, res in results.items():
            name = os.path.basename(log_dir)
            output_data.append(f"{name}-obj,{res['cost']},{name}-diff,{res['changed']},{name}-time,{res['time']}")

        print(",".join(output_data))

if __name__ == "__main__":
    main()
