#!/bin/bash

past_dir="tmp-past"
curr_dir="tmp-curr"
base_date="2025-09-08"

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

seed_list=(0 1 2 3 4 5 6 7 8 9)
for seed in "${seed_list[@]}"; do
    # Generate instances for both past and current directories
    scripts/make-instances.sh -o "$past_dir" -s $seed -d "$base_date" -t -1
    scripts/make-instances.sh -o "$curr_dir" -s $seed -d "$base_date" -t 0
done
