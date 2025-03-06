#!/bin/bash

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# ./make-exp-jobs.sh -t 300 -i presolved-t300 -o resolved-t300 > exp-jobs-t300.txt
# xargs -P 8 -I {} --verbose -a exp-jobs-t300.txt bash -c "{}"

# ./make-exp-jobs.sh -a "-f d0-13 -c d21-27" -t 300 -i presolved-t300 -o resolved-f2wp1wc1w-t300 > exp-jobs-f2wp1wc1w-t300.txt
# xargs -P 8 -I {} --verbose -a exp-jobs-f2wp1wc1w-t300.txt bash -c "{}"

# ./make-exp-jobs.sh -a "-c d14-27" -t 300 -i presolved-t300 -r requests-28d -o resolved-p14d-c14d-t300 > exp-jobs-p14d-c14d-t300.txt
# xargs -P 12 -I {} --verbose -a exp-jobs-p14d-c14d-t300.txt bash -c "{}"

# ./make-exp-jobs.sh -a "-c d14-27" -t 600 -i presolved-t600 -r requests-28d -o resolved-p14d-c14d-t600 > exp-jobs-p14d-c14d-t600.txt
# xargs -P 12 -I {} --verbose -a exp-jobs-p14d-c14d-t600.txt bash -c "{}"

# ./make-exp-jobs.sh -a "-f d0-9 -c d19-27" -t 600 -i presolved-t600 -r requests-18d -o resolved-f10d-p9d-c9d-t600 > exp-jobs-f10d-p9d-c9d-t600.txt
# xargs -P 12 -I {} --verbose -a exp-jobs-f10d-p9d-c9d-t600.txt bash -c "{}"

# ./make-exp-jobs.sh -t 600 -i presolved-t600 -r requests-28d -o resolved-p28d-t600 > exp-jobs-p28d-t600.txt
# xargs -P 12 -I {} --verbose -a exp-jobs-p28d-t600.txt bash -c "{}"

./make-exp-jobs.sh -a "-c d14-27" -t 3600 -i presolved-t8-3600 -r requests-28d -o resolved-p14d-c14d-3600 > exp-jobs-p14d-c14d-3600.txt
xargs -P 16 -I {} --verbose -a exp-jobs-p14d-c14d-3600.txt bash -c "{}"
