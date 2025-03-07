#!/usr/bin/env python3
import argparse
import glob
import os
import re
import subprocess
import sys

import numpy as np
import pandas as pd

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

    freq = 0
    for line in results.split("\n"):
        match = pattern.match(line)
        if match:
            freq += 1
            no, costs, elapsed, changed = match.groups()
            no = int(no)
            costs = list(map(int, costs.split()))
            elapsed = float(elapsed)
            changed = int(changed)

            if timeout == None or (elapsed <= timeout and elapsed > nearest_elapsed):
                nearest_entry = {"no": no, "costs": costs, "time": elapsed, "freq": freq, "changed": changed}
                nearest_elapsed = elapsed
            if timeout != None and timeout < elapsed:
                break

    return nearest_entry

def normalize_objective_values(experiment_results):
    """
    Normalize objective function values to the range [0,1] using Min-Max normalization.

    :param experiment_results: dict
        - Key: Experiment name (e.g., "exp1", "exp2", ...)
        - Value: List of objective function values (e.g., [f1, f2, ..., fn])
    :return: dict
        - A dictionary containing normalized objective function values
    """
    # Extract keys and convert values to a NumPy array
    keys = list(experiment_results.keys())
    values = np.array(list(experiment_results.values()))  # Shape: (num_experiments, num_objectives)

    # # Identify columns where all values are the same (constant objective functions)
    # non_constant_mask = np.any(values != values[0, :], axis=0)
    # values = values[:, non_constant_mask]

    # Compute min and max for each remaining objective function
    min_vals = np.min(values, axis=0)
    max_vals = np.max(values, axis=0)

    # Handle cases where max == min (avoid division by zero)
    range_vals = max_vals - min_vals
    range_vals[range_vals == 0] = 1  # Set to 1 to prevent division by zero

    # Apply Min-Max normalization
    normalized_values = (values - min_vals) / range_vals

    # Convert back to dictionary format
    normalized_results = {key: norm_vals.tolist() for key, norm_vals in zip(keys, normalized_values)}

    return normalized_results

def compute_weighted_sum(normalized_results, base=10):
    """
    Compute a weighted sum of normalized objective values using Exponentially Decreasing Weights.

    :param normalized_results: dict
        - A dictionary containing normalized objective function values.
    :param base: int
        - Base for exponentially decreasing weights (default: 10).
    :return: dict
        - A dictionary containing the weighted score for each experiment.
    """
    if not normalized_results:
        return {}  # Return empty if no objectives remain

    num_objectives = len(next(iter(normalized_results.values())))  # Get the number of objectives
    weights = [base ** (num_objectives - i - 1) for i in range(num_objectives)]

    weighted_scores = {
        key: sum(w * f for w, f in zip(weights, values))
        for key, values in normalized_results.items()
    }

    return weighted_scores

def main():
    parser = argparse.ArgumentParser(description="Extract results from log files")
    parser.add_argument("-l", "--log-dir", type=str, help="Path to the directory containing log files")
    parser.add_argument("-t", "--timeout", type=int, default=None, metavar="SECONDS", help="Time limit for solving (in seconds)")

    args = parser.parse_args()

    priorities = ["hi", "mid", "low"]
    instances = sorted([os.path.basename(f)[:-3] for f in glob.glob("instances/nsp-*.lp")])
    log_dirs  = [(f"{args.log_dir}/lnps", "lnps")]
    log_dirs += [(f"{args.log_dir}/mp-p-{p}",p) for p in priorities]
    #log_dirs += [(f"{args.log_dir}/mp-ps-p-{p}",p) for p in priorities]
    log_dirs += [(f"{args.log_dir}/mp-is-p-{p}",p) for p in priorities]

    csv_data = {}
    for instance in instances:
        #print(f"Instance: {instance}")

        results = {}
        costs = {}
        for log_dir, priority in log_dirs:
            log_file = f"{log_dir}/{instance}.log"
            #print(f"log_file: {log_file}")
            results[log_dir] = extract_result(log_file, args.timeout)
            # print(f"{log_file}: {results[log_dir]}")
            if results[log_dir]:
                cs = results[log_dir]['costs']
                if priority == "hi":
                    changed = cs.pop(0) # remove the first cost
                    assert changed == results[log_dir]['changed']
                elif priority == "mid":
                    changed = cs.pop(-3) # remove the second last cost
                    assert changed == results[log_dir]['changed']
                elif priority == "low":
                    changed = cs.pop(-1) # remove the last cost
                    assert changed == results[log_dir]['changed']
                results[log_dir]['org-costs'] = " ".join(map(str, cs))
                costs[log_dir] = cs

        if None in results.values():
            continue

        # Normalize the costs
        normalized_costs = normalize_objective_values(costs)
        for log_dir, costs in normalized_costs.items():
            results[log_dir]['nrm-costs'] = " ".join(f"{x:.2f}" for x in costs)

        weighted_cost = compute_weighted_sum(normalized_costs, base=10)
        for log_dir, cost in weighted_cost.items():
            results[log_dir]['cost'] = cost

        out_results = {}
        for log_dir, res in results.items():
            name = os.path.basename(log_dir)
            out_results[f"{name}-org-obj"] = res['org-costs']
            out_results[f"{name}-nrm-obj"] = res['nrm-costs']
            out_results[f"{name}-obj"] = f"{res['cost']:.2f}"
            out_results[f"{name}-diff"] = res['changed']
            out_results[f"{name}-freq"] = res['freq']
        csv_data[instance] = out_results

    df = pd.DataFrame.from_dict(csv_data, orient="index")
    df.to_csv(sys.stdout)

if __name__ == "__main__":
    main()
