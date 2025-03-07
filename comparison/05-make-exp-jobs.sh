#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# scripts/make-exp-jobs.sh -a "-c d14-27" -t 60 -i presolved-3600 -r requests-28d -o resolved-p14d-c14d-60
scripts/make-exp-jobs.sh -a "-c d0-27" -t 3600 -i presolved-3600 -r requests-28d -o resolved-c28d-3600
scripts/make-exp-jobs.sh -a "-c d7-27" -t 3600 -i presolved-3600 -r requests-28d -o resolved-p7d-c21d-3600
scripts/make-exp-jobs.sh -a "-c d14-27" -t 3600 -i presolved-3600 -r requests-28d -o resolved-p14d-c14d-3600
scripts/make-exp-jobs.sh -a "-c d21-27" -t 3600 -i presolved-3600 -r requests-28d -o resolved-p21d-c7d-3600
scripts/make-exp-jobs.sh -t 3600 -i presolved-3600 -r requests-28d -o resolved-p28d-3600
# scripts/make-exp-jobs.sh -a "-f d0-13 -c d21-27" -t 3600 -i presolved-3600 -r requests-14d -o resolved-f14d-p7d-c7d-3600
