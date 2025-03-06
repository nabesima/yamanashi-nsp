#!/bin/bash

# Default values
request_ratio=0.05
start_day=0
window=0
output_dir="requests"

# Parse command-line options using getopts
while getopts "r:s:w:o:" opt; do
  case ${opt} in
    r )
      request_ratio=${OPTARG}
      ;;
    s )
      start_day=${OPTARG}
      ;;
    w )
      window=${OPTARG}
      ;;
    o )
      output_dir=${OPTARG}
      ;;
    \? )
      echo "Usage: $0 [-r request_ratio] [-s start_day] [-w window] [-o output_dir]"
      exit 1
      ;;
  esac
done

# Create the output directory
mkdir -p "$output_dir"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all *.lp files in the current directory
for inst in instances/nsp-*.lp; do
    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    requests="$output_dir/${base_name}.lp"

    nurses="${base_name#*-n}" # Remove everything up to and including '-n', resulting in "40-d28-r0.10-rp2-fp2-s0.lp"
    nurses="${nurses%%-*}"    # Remove everything after the first '-', keeping only "40"

    days="${base_name#*-d}"   # Remove everything up to and including '-d', resulting in "28-r0.10-rp2-fp2-s0.lp"
    days="${days%%-*}"        # Remove everything after the first '-', keeping only "28"

    num_requests=$(awk "BEGIN {print int(($nurses * $window * $request_ratio) + 0.5)}")

    seed="${base_name##*-s}"

    # Make new staff requests with start day, window, and output directory options
    ./make-staff-requests.py -n $nurses -d $days -r $num_requests --seed $seed -s $start_day -w $window > "$requests"
done
