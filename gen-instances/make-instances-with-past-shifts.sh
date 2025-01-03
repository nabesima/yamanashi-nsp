#!/bin/bash

past_dir="tmp-past"
curr_dir="tmp-curr"
base_date="2025-09-08"
solve_limit=100000

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

# Generate instances for both past and current directories
./make-instances.sh -o "$past_dir" -s 0 -d "$base_date" -t -1
./make-instances.sh -o "$curr_dir" -s 0 -d "$base_date" -t 0

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all *.lp files in the past_dir
for past_inst in "$past_dir"/*.lp; do
    echo "Processing instance: $past_inst"
    base_name="$(basename "$past_inst" .lp)"
    model="$past_dir/${base_name}.model"
    past_shift="$past_dir/${base_name}.past"
    log_file="$past_dir/${base_name}.log"

    # Solve the past instance with specified solve limit
    ../nspsolver.py ../nsp.lp "$past_inst" -o "$model" --solve-limit="$solve_limit" --seed=0 --stats > "$log_file" 2>&1

    # Generate past shift data
    ../model2pastshift.py "$model" > "$past_shift"

    # Concatenate the current instance and the past shift data
    curr_inst="$curr_dir/${base_name}.lp"
    output_inst="${base_name}.lp"

    if [ -f "$curr_inst" ]; then
        cat "$curr_inst" "$past_shift" > "$output_inst"
    else
        echo "Warning: $curr_inst not found, skipping concatenation."
    fi
done
