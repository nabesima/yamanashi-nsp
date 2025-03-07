#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

scripts/extract-results.py -l resolved-p14d-c14d-60 > resolved-p14d-c14d-60/results.csv
scripts/extract-results.py -l resolved-p14d-c14d-t4-60 > resolved-p14d-c14d-t4-60/results.csv
scripts/extract-results.py -l resolved-p14d-c14d-3600 -t 60   > resolved-p14d-c14d-3600/results60.csv
scripts/extract-results.py -l resolved-p14d-c14d-3600 -t 600  > resolved-p14d-c14d-3600/results600.csv
scripts/extract-results.py -l resolved-p14d-c14d-3600 -t 1800 > resolved-p14d-c14d-3600/results1800.csv
scripts/extract-results.py -l resolved-p14d-c14d-3600         > resolved-p14d-c14d-3600/results3600.csv
scripts/extract-results.py -l resolved-p14d-c14d-t4-3600 -t 60   > resolved-p14d-c14d-t4-3600/results60.csv
scripts/extract-results.py -l resolved-p14d-c14d-t4-3600 -t 600  > resolved-p14d-c14d-t4-3600/results600.csv
scripts/extract-results.py -l resolved-p14d-c14d-t4-3600 -t 1800 > resolved-p14d-c14d-t4-3600/results1800.csv
scripts/extract-results.py -l resolved-p14d-c14d-t4-3600         > resolved-p14d-c14d-t4-3600/results3600.csv
