#!/bin/bash

solve_limit=""
time_limit=""
in_dir="presolved"       # Default input directory
requests_dir="requests"  # Default requests directory
out_dir="resolved"       # Default output directory
area_setting=""          # Default area setting

# Parse command line arguments using getopts
while getopts ":a:l:t:i:r:o:" opt; do
    case ${opt} in
        a)
            area_setting=${OPTARG}
            ;;
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            time_limit=${OPTARG}
            ;;
        i)
            in_dir=${OPTARG}
            ;;
        r)
            requests_dir=${OPTARG}
            ;;
        o)
            out_dir=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-i in_dir] [-r request_dir] [-o out_dir]"
            exit 1
            ;;
    esac
done

# Construct clingo options
options=""
if [[ -n "$solve_limit" ]]; then
    options+=" --solve-limit=$solve_limit"
fi
if [[ -n "$time_limit" ]]; then
    options+=" --timeout $time_limit"
fi

# Create the output directories
lnps_dir="$out_dir/lnps"
mp_dir="$out_dir/mp"
mp_ps_dir="$out_dir/mp-ps"
mp_is_dir="$out_dir/mp-is"

mkdir -p "$lnps_dir"
priority_list=(1 2 3)
for priority in "${priority_list[@]}"; do
  mkdir -p "$mp_dir-p${priority}"
  mkdir -p "$mp_ps_dir-p${priority}"
  mkdir -p "$mp_is_dir-p${priority}"
done

# Loop through all *.lp files in the current dit
for inst in instances/nsp-*.lp; do

    base_name="$(basename "$inst" .lp)"
    requests_file="${requests_dir}/${base_name}.lp"
    old_model_file="${in_dir}/${base_name}.model"

    days="${base_name#*-d}" # Remove everything up to and including '-d', resulting in "28-r0.10-rp2-fp2-s0.lp"
    days="${days%%-*}"      # Remove everything after the first '-', keeping only "28"
    didx=$(((days / 2) - 1))

    # LNPS
    new_model_file="$lnps_dir/${base_name}.model"
    log_file="$lnps_dir/${base_name}.log"

    echo "../nspsolver.py ../nsp.lp $inst $requests_file "  \
        "-i $old_model_file --lnps -o $new_model_file $area_setting " \
        "$options --configuration=trendy --stats > $log_file 2>&1"

    for priority in "${priority_list[@]}"; do

        # MP
        out_subdir="$mp_dir-p${priority}"
        new_model_file="$out_subdir/${base_name}.model"
        log_file="$out_subdir/${base_name}.log"

        echo "../nspsolver.py ../nsp-mp.lp $inst $requests_file " \
            "-i $old_model_file -o $new_model_file $area_setting " \
            "$options --configuration=trendy --const mp_priority=$priority --stats > $log_file 2>&1"

        # MP + PS
        out_subdir="$mp_ps_dir-p${priority}"
        new_model_file="$out_subdir/${base_name}.model"
        log_file="$out_subdir/${base_name}.log"

        echo "../nspsolver.py ../nsp-mp+ps.lp $inst $requests_file " \
            "-i $old_model_file -o $new_model_file $area_setting " \
            "$options --configuration=trendy --const mp_priority=$priority --stats > $log_file 2>&1"

        # MP + IS
        out_subdir="$mp_is_dir-p${priority}"
        new_model_file="$out_subdir/${base_name}.model"
        log_file="$out_subdir/${base_name}.log"

        echo "../nspsolver.py ../nsp-mp+is.lp $inst $requests_file " \
            "-i $old_model_file -o $new_model_file $area_setting " \
            "$options --configuration=trendy --const mp_priority=$priority --stats > $log_file 2>&1"
    done
done
