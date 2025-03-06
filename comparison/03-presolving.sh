#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

scripts/presolve.sh -t 3600 -o presolved-3600
