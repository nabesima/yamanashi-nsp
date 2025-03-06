#!/bin/bash

past_dir="tmp-past"
curr_dir="tmp-curr"
output_dir="instances"
base_date="2025-09-08"
solve_limit=""
time_limit=""
parallel_jobs="1"

# Parse command line arguments using getopts
while getopts ":l:t:p:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            time_limit=${OPTARG}
            ;;
        p)
            parallel_jobs=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-p parallel_jobs]"
            exit 1
            ;;
    esac
done

# Construct nspsolver options
options=""
if [[ -n "$solve_limit" ]]; then
    options+=" --solve-limit=$solve_limit"
fi
if [[ -n "$time_limit" ]]; then
    options+=" --timeout $time_limit"
fi

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

seed_list=(0 1 2 3 4 5 6 7 8 9)
for seed in "${seed_list[@]}"; do
    # Generate instances for both past and current directories
    ./make-instances.sh -o "$past_dir" -s $seed -d "$base_date" -t -1
    ./make-instances.sh -o "$curr_dir" -s $seed -d "$base_date" -t 0
done

# Create the output directory
mkdir -p "$output_dir"

# Function to process an individual instance
process_instance() {
    past_inst="$1"
    echo "Processing instance: $past_inst"
    base_name="$(basename "$past_inst" .lp)"
    model="$past_dir/${base_name}.model"
    past_shift="$past_dir/${base_name}.past"
    log_file="$past_dir/${base_name}.log"
    seed="${base_name##*-s}"

    # Solve the past instance with specified solve limit
    ../nspsolver.py ../nsp.lp "$past_inst" -o "$model" $options --configuration=trendy --seed=$seed --stats > "$log_file" 2>&1

    # Generate past shift data
    ../model2pastshift.py "$model" > "$past_shift"

    # Concatenate the current instance and the past shift data
    curr_inst="$curr_dir/${base_name}.lp"
    output_inst="${output_dir}/${base_name}.lp"

    if [ -f "$curr_inst" ]; then
        cat "$curr_inst" "$past_shift" > "$output_inst"
    else
        echo "Warning: $curr_inst not found, skipping concatenation."
    fi
}

export -f process_instance
export past_dir curr_dir output_dir options

# Find all .lp files and process them in parallel using xargs
find "$past_dir" -name "*.lp" | sort | xargs -P "$parallel_jobs" -I {} bash -c 'process_instance "$@"' _ {}
