#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

#./extract-results.py -l resolved-p14d-c14d-t300 > resolved-p14d-c14d-t300/results.csv
# ./extract-results.py -l resolved-p14d-c14d-t600 > resolved-p14d-c14d-t600/results.csv
# ./extract-results.py -l resolved-p28d-t600 > resolved-p28d-t600/results.csv
./extract-results.py -l resolved-p14d-c14d-3600 > resolved-p14d-c14d-3600/results.csv
./extract-results.py -l resolved-p14d-c14d-3600 -t 60 > resolved-p14d-c14d-3600/results60.csv
./extract-results.py -l resolved-p14d-c14d-3600 -t 300 > resolved-p14d-c14d-3600/results300.csv
./extract-results.py -l resolved-p14d-c14d-3600 -t 600 > resolved-p14d-c14d-3600/results600.csv