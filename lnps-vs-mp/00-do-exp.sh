#!/bin/bash

solve_limit=10000000

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

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

./make-instances-with-past-shifts.sh -l $solve_limit
./presolve.sh -l $solve_limit
./make-staff-requests.sh
./evaluate.sh -l $solve_limit
