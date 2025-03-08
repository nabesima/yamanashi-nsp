#!/bin/bash

timeouts=(60 600 3600)

for log_dir in resolved-*; do
    # Extract the unique identifier from the directory name
    identifier=${log_dir#resolved-}   # Remove "resolved-"
    identifier=${identifier%-3600*}  # Remove "-3600" and everything after

    for timeout in "${timeouts[@]}"; do
        input_file="${log_dir}/results${timeout}.csv"
        output_file="${log_dir}/fig-${identifier}-${timeout}.pdf"

        # Check if the input file exists before processing
        if [ ! -f "$input_file" ]; then
            echo "Skipping: $input_file does not exist."
            continue
        fi

        echo "Processing: $input_file -> $output_file"
        scripts/make-figs.py "$input_file" "$output_file"
    done
done
