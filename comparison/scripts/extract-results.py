#!/usr/bin/env python3
import argparse
import glob
import os
import re
import sys
import pathlib

import numpy as np
import pandas as pd

def strip_ansi_codes(text):
    return re.sub(r'\x1b\[[0-9;]*m', '', text)

pattern = re.compile(r".*Answer: (\d+), Cost: (.+), Elapsed: (\d+.\d+)s, (#Changed: (\d+))?")
def extract_result(file, timeout=None):
    if not os.path.exists(file):
        return None

    nearest_entry = None
    nearest_elapsed = float('-inf')
    freq = 0

    try:
        with open(file, "r", encoding="utf-8") as f:
            for line in f:
                match = pattern.match(line)
                if match:
                    freq += 1
                    no, costs, elapsed, _, changed = match.groups()
                    no = int(no)
                    costs = list(map(int, costs.split()))
                    elapsed = float(elapsed)
                    if changed is not None:
                        changed = int(changed)

                    if timeout is None or (elapsed <= timeout and elapsed > nearest_elapsed):
                        nearest_entry = {"no": no, "costs": costs, "time": elapsed, "freq": freq, "changed": changed}
                        nearest_elapsed = elapsed

                    if timeout is not None and elapsed > timeout:
                        break
    except Exception:
        return None

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
    parser.add_argument("-t", "--timeout", type=int, metavar="SECONDS", help="Time limit for solving (in seconds)")

    args = parser.parse_args()

    log_files = glob.glob(f"{args.log_dir}/**/*.log", recursive=True)
    if not log_files:
        print(f"No log files found in '{args.log_dir}'")
        sys.exit(1)

    results = {}
    for log_file in log_files:
        path = pathlib.Path(log_file)
        exp_name = path.parent.parent     # experiment name
        strategy_name = path.parent.name  # strategy name
        inst_name = path.stem             # instance name

        stats = extract_result(log_file, args.timeout)
        if stats is None:
            continue

        # Remove MP objective value from the costs
        cs = stats['costs']
        if stats['changed'] is not None:
            if "-hi" in strategy_name:
                changed = cs.pop(0) # remove the first cost
                assert changed == stats['changed'], f"{changed} != {stats['changed']}"
            elif "-mid" in strategy_name:
                changed = cs.pop(-3) # remove the second last cost
                assert changed == stats['changed'], f"{changed} != {stats['changed']}"
            elif "-low" in strategy_name:
                changed = cs.pop(-1) # remove the last cost
                assert changed == stats['changed'], f"{changed} != {stats['changed']}"
        stats['org-costs'] = " ".join(map(str, cs))

        if stats['changed'] is not None:
            # Extract the number of nurses
            match = re.search(r"nsp-n(\d+)-d(\d+)", inst_name)
            if match is None:
                raise ValueError(f"Unexpected instance name: {inst_name}")
            nurses = int(match.group(1))
            # Extract the number of prioritized days
            match = re.search(r"-p(\d+)d-", exp_name.name)
            if match is None:
                days = 0
            else:
                days = int(match.group(1))
            stats['org-changed'] = changed
            stats['changed'] = changed / (nurses * days)

        exp_inst_name = f"{exp_name}/{inst_name}"
        if exp_inst_name not in results:
            results[exp_inst_name] = {}
        results[exp_inst_name][strategy_name] = stats
    # print(f"results: {results}")

    for exp_inst_name in results:
        costs = {key: value['costs'] for key, value in results[exp_inst_name].items()}

        # Normalize the costs
        normalized_costs = normalize_objective_values(costs)
        for strategy, costs in normalized_costs.items():
            results[exp_inst_name][strategy]['nrm-costs'] = " ".join(f"{x:.2f}" for x in costs)

        weighted_cost = compute_weighted_sum(normalized_costs, base=10)
        for strategy, cost in weighted_cost.items():
            results[exp_inst_name][strategy]['cost'] = cost

    out_results = {}
    for exp_inst_name in results:
        out_results[exp_inst_name] = {}
        for strategy in sorted(results[exp_inst_name]):
            stats = results[exp_inst_name][strategy]
            out_results[exp_inst_name][f"{strategy}-org-obj"] = stats['org-costs']
            out_results[exp_inst_name][f"{strategy}-nrm-obj"] = stats['nrm-costs']
            out_results[exp_inst_name][f"{strategy}-obj"] = f"{stats['cost']:.2f}"
            out_results[exp_inst_name][f"{strategy}-diff"] = f"{stats['changed']:.2f}" if stats['changed'] is not None else 0
            out_results[exp_inst_name][f"{strategy}-freq"] = stats['freq']

    df = pd.DataFrame.from_dict(out_results, orient="index")
    df.to_csv(sys.stdout)

if __name__ == "__main__":
    main()
