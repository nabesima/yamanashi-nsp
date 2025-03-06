#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

./presolve.sh -t 1800 -j 16 -o presolved-1800
# ./presolve.sh -t 3600 -j 16 -o presolved-3600
# ./presolve.sh -t 3600 -j 2 -p 8 -o presolved-t8-3600
