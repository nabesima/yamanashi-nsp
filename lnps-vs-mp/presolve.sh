#!/bin/bash

solve_limit=500000

# Parse command line arguments using getopts
while getopts ":l:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit]"
            exit 1
            ;;
    esac
done

# Create the output directory
presolving_dir="presolving"
mkdir -p "$presolving_dir"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all *.lp files in the current directory
for inst in nsp-*.lp; do
    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    model="$presolving_dir/${base_name}.model"
    log_file="$presolving_dir/${base_name}.log"
    seed="${base_name##*-s}"

    # Solve the past instance with specified solve limit
    ../nspsolver.py ../nsp.lp "$inst" no_hard_priority.lp -o "$model" --solve-limit="$solve_limit" --configuration=trendy --seed=$seed --stats > "$log_file" 2>&1
done