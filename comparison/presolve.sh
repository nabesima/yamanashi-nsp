#!/bin/bash

solve_limit=""
time_limit=""
parallel_jobs=1
parallel_threads=1
out_dir="presolved"  # Default output directory

# Parse command line arguments using getopts
while getopts ":l:t:j:p:o:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            time_limit=${OPTARG}
            ;;
        j)
            parallel_jobs=${OPTARG}
            ;;
        p)
            parallel_threads=${OPTARG}
            ;;
        o)
            out_dir=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-j parallel_jobs] [-p parallel_threads] [-o out_dir]"
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

# Create the output directory
mkdir -p "$out_dir"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Function to process an individual instance
process_instance() {
    inst="$1"
    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    model="$out_dir/${base_name}.model"
    log_file="$out_dir/${base_name}.log"
    seed="${base_name##*-s}"

    if [ $parallel_threads -eq 1 ]; then
        config_opts=" --configuration=trendy --seed=$seed"
    else
        config_opts=" -t $parallel_threads"
    fi

    # Solve the instance with specified solve limit
    ../nspsolver.py ../nsp.lp "$inst" -o "$model" $options $config_opts --stats > "$log_file" 2>&1
}

export -f process_instance
export out_dir options parallel_threads

# Find all .lp files and process them in parallel using xargs
find instances -name "nsp-*.lp" | sort | xargs -P $parallel_jobs -I {} bash -c 'process_instance "$@"' _ {}
