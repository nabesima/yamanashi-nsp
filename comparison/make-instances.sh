#!/bin/bash

# Default output directory, random seed, start date, and schedule offset
OUTPUT_DIR="."
SEED=0
START_DATE="2025-04-01"
SCHEDULE_OFFSET=0

# Parse options using getopts
while getopts ":o:s:d:t:" opt; do
  case ${opt} in
    o )
      OUTPUT_DIR=${OPTARG}
      ;;
    s )
      SEED=${OPTARG}
      ;;
    d )
      START_DATE=${OPTARG}
      ;;
    t )
      SCHEDULE_OFFSET=${OPTARG}
      ;;
    \? )
      echo "Usage: $0 [-o output_directory] [-s seed] [-d start_date] [-t schedule-offset]"
      exit 1
      ;;
  esac
done

# Lists for number of nurses, days, staff request rates, and pairs
NURSES_LIST=(10 20 30 40 50)
DAYS_LIST=(28)
STAFF_REQUEST_LIST=(0.10)
PAIRS=(2)

# Create the output directory
mkdir -p "$OUTPUT_DIR"

# Generate all combinations of parameters
for NURSES in "${NURSES_LIST[@]}"; do
    for DAYS in "${DAYS_LIST[@]}"; do
        for STAFF_REQUEST in "${STAFF_REQUEST_LIST[@]}"; do
            if [ "$NURSES" -ge 20 ]; then
                for PAIR in "${PAIRS[@]}"; do
                    RECOMMENDED_PAIRS=$PAIR
                    FORBIDDEN_PAIRS=$PAIR
                    OUTPUT_FILE="${OUTPUT_DIR}/nsp-n${NURSES}-d${DAYS}-r${STAFF_REQUEST}-rp${RECOMMENDED_PAIRS}-fp${FORBIDDEN_PAIRS}-s${SEED}.lp"
                    echo "Generating NSP instance: Nurses=${NURSES}, Days=${DAYS}, Staff Request=${STAFF_REQUEST}, Recommended Pairs=${RECOMMENDED_PAIRS}, Forbidden Pairs=${FORBIDDEN_PAIRS}, Schedule Offset=${SCHEDULE_OFFSET}, Seed=${SEED}"
                    ../gennsp.py -n "$NURSES" -d "$DAYS" -s "$START_DATE" -r "$STAFF_REQUEST" -rp "$RECOMMENDED_PAIRS" -fp "$FORBIDDEN_PAIRS" --schedule-offset "$SCHEDULE_OFFSET" --seed "$SEED" > "$OUTPUT_FILE"
                done
            else
                RECOMMENDED_PAIRS=0
                FORBIDDEN_PAIRS=0
                OUTPUT_FILE="${OUTPUT_DIR}/nsp-n${NURSES}-d${DAYS}-r${STAFF_REQUEST}-rp${RECOMMENDED_PAIRS}-fp${FORBIDDEN_PAIRS}-s${SEED}.lp"
                echo "Generating NSP instance: Nurses=${NURSES}, Days=${DAYS}, Staff Request=${STAFF_REQUEST}, Recommended Pairs=${RECOMMENDED_PAIRS}, Forbidden Pairs=${FORBIDDEN_PAIRS}, Schedule Offset=${SCHEDULE_OFFSET}, Seed=${SEED}"
                ../gennsp.py -n "$NURSES" -d "$DAYS" -s "$START_DATE" -r "$STAFF_REQUEST" -rp "$RECOMMENDED_PAIRS" -fp "$FORBIDDEN_PAIRS" --schedule-offset "$SCHEDULE_OFFSET" --seed "$SEED" > "$OUTPUT_FILE"
            fi
        done
    done
done

echo "All NSP instances have been generated successfully in $OUTPUT_DIR"
