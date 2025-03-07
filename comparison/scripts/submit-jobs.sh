#!/bin/bash

# Exit with an error message if no arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Use find to search for .sh files in the given directories
# Sort by filename first, and by full path if filenames are the same
find "$@" -type f -name "*.sh" 2>/dev/null | awk -F/ '{print $NF, $0}' | sort -k1,1 -k2 | cut -d' ' -f2- | xargs -r -n 1 sbatch
