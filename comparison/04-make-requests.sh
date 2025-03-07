#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

scripts/make-staff-requests.sh -s 14 -w 14 -o requests-14d
scripts/make-staff-requests.sh -s 10 -w 18 -o requests-18d
scripts/make-staff-requests.sh -s  0 -w 28 -o requests-28d
