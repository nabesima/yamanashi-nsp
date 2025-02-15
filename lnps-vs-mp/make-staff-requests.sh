#!/bin/bash

# Create the output directory
requests_dir="requests"
mkdir -p "$requests_dir"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all *.lp files in the current dit
for inst in nsp-*.lp; do
    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    requests="$requests_dir/${base_name}.lp"

    nurses="${base_name#*-n}" # Remove everything up to and including '-n', resulting in "40-d28-r0.10-rp2-fp2-s0.lp"
    nurses="${nurses%%-*}"    # Remove everything after the first '-', keeping only "40"

    days="${base_name#*-d}"   # Remove everything up to and including '-d', resulting in "28-r0.10-rp2-fp2-s0.lp"
    days="${days%%-*}"        # Remove everything after the first '-', keeping only "28"

    seed="${base_name##*-s}"

    # Make new staff requests
    ./make-staff-requests.py -n $nurses -d $days --seed $seed > "$requests"
done