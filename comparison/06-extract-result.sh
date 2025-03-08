#!/bin/bash

timeouts=(60 600 3600)

# Enable debugging and strict error handling
# export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
# set -uxo pipefail

for log_dir in resolved-*; do
    echo "Processing logs in $log_dir..."
    for timeout in "${timeouts[@]}"; do
        output_file="${log_dir}/results${timeout}.csv"

        # Check if there are any .log files in log_dir (recursively)
        log_count=$(find -L "$log_dir" -type f -name "*.log" | wc -l)
        if [ "$log_count" -eq 0 ]; then
            echo "No log files found in $log_dir, skipping..."
            continue
        fi

        # Find the most recently modified .log file (recursively)
        newest_log_mtime=$(find -L "$log_dir" -type f -name "*.log" -printf "%T@\n" 2>/dev/null | sort -nr | head -n1)

        # If output_file does not exist, process the logs
        if [ ! -e "$output_file" ]; then
            echo "Output file $output_file does not exist. Processing..."
            scripts/extract-results.py -l "$log_dir" -t "$timeout" > "$output_file"
            continue
        fi

        # Get the last modified time of the output file
        output_mtime=$(stat -c %Y "$output_file")

        # Process only if there are newer log files than the output file
        if (( $(echo "$newest_log_mtime > $output_mtime" | bc -l) )); then
            echo "New log files found in $log_dir, updating $output_file..."
            scripts/extract-results.py -l "$log_dir" -t "$timeout" > "$output_file"
        else
            echo "No new logs in $log_dir, skipping $output_file."
        fi
    done
done
