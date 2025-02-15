#!/bin/bash

solve_limit=500000
threads=1

# Parse command line arguments using getopts
while getopts ":l:t:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            threads=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t threads]"
            exit 1
            ;;
    esac
done

# Create the output directories
lnps_dir="lnps"
mp_dir="min-perturb"
mkdir -p "$lnps_dir"
mkdir -p "$mp_dir"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all *.lp files in the current dit
for inst in nsp-*.lp; do

    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    requests_file="requests/${base_name}.lp"
    old_model_file="presolving/${base_name}.model"
    new_model_file="$lnps_dir/${base_name}.model"
    legacy_file="$lnps_dir/${base_name}.legacy"
    log_file="$lnps_dir/${base_name}.log"

    days="${base_name#*-d}" # Remove everything up to and including '-d', resulting in "28-r0.10-rp2-fp2-s0.lp"
    days="${days%%-*}"      # Remove everything after the first '-', keeping only "28"
    didx=$(((days / 2) - 1))

    # LNPS
    ../nspsolver.py ../nsp.lp $inst no_hard_priority.lp $requests_file \
        -p $old_model_file -o $new_model_file -l $legacy_file -s -f d0-$didx \
        --solve-limit="$solve_limit" -t $threads --configuration=trendy --stats > "$log_file" 2>&1

    new_model_file="$mp_dir/${base_name}.model"
    legacy_file="$mp_dir/${base_name}.legacy"
    log_file="$mp_dir/${base_name}.log"

    # MP
    ../nspsolver.py ../nsp-mp.lp $inst no_hard_priority.lp $requests_file \
        -p $old_model_file -o $new_model_file -l $legacy_file -s -f d0-$didx \
        --solve-limit="$solve_limit" -t $threads --configuration=trendy --stats > "$log_file" 2>&1

done