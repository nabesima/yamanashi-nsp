#!/bin/bash

solve_limit=""
time_limit=""
in_dir="presolved"       # Default input directory
requests_dir="requests"  # Default requests directory
parallel_threads=1       # Default number of parallel threads
out_dir="resolved"       # Default output directory
area_setting=""          # Default area setting

# Parse command line arguments using getopts
while getopts ":a:l:t:i:r:p:o:" opt; do
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
        p)
            parallel_threads=${OPTARG}
            ;;
        o)
            out_dir=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-i in_dir] [-r request_dir] [-p parallel_threads] [-o out_dir]"
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

priority_list=("hi" "mid" "low")
declare -A priority_map
priority_map["hi"]=20
priority_map["mid"]=3
priority_map["low"]=0

# Declare mappings
declare -A out_dir_map
declare -A slurm_dir_map
declare -A encoding_map
declare -A option_map
out_dir_map["lnps"]="$out_dir/lnps"
slurm_dir_map["lnps"]="tmp-$out_dir/lnps"
encoding_map["lnps"]="nsp.lp"
option_map["lnps"]="--lnps"
for priority in "${priority_list[@]}"; do
    out_dir_map["mp-p-${priority}"]="$out_dir/mp-p-${priority}"
    out_dir_map["mp-ps-p-${priority}"]="$out_dir/mp-ps-p-${priority}"
    out_dir_map["mp-is-p-${priority}"]="$out_dir/mp-is-p-${priority}"
    slurm_dir_map["mp-p-${priority}"]="tmp-$out_dir/mp-p-${priority}"
    slurm_dir_map["mp-ps-p-${priority}"]="tmp-$out_dir/mp-ps-p-${priority}"
    slurm_dir_map["mp-is-p-${priority}"]="tmp-$out_dir/mp-is-p-${priority}"
    encoding_map["mp-p-${priority}"]="nsp-mp.lp"
    encoding_map["mp-ps-p-${priority}"]="nsp-mp+ps.lp"
    encoding_map["mp-is-p-${priority}"]="nsp-mp+is.lp"
    option_map["mp-p-${priority}"]="--const mp_priority=${priority_map[$priority]}"
    option_map["mp-ps-p-${priority}"]="--const mp_priority=${priority_map[$priority]}"
    option_map["mp-is-p-${priority}"]="--const mp_priority=${priority_map[$priority]}"
done

# Make output directories
for key in "${!out_dir_map[@]}"; do
    mkdir -p "${out_dir_map[$key]}"
    mkdir -p "${slurm_dir_map[$key]}"
done

# Function to process an individual instance
process_instance() {
    inst="$1"
    strategy="$2"

    echo "Processing instance: $inst"

    encoding="../encoding/${encoding_map[$strategy]}"
    strategy_options="${option_map[$strategy]}"

    base_name="$(basename "$inst" .lp)"
    requests_file="${requests_dir}/${base_name}.lp"
    old_model_file="${in_dir}/${base_name}.model"

    new_model_file="${out_dir_map[$key]}/${base_name}.model"
    log_file="${out_dir_map[$key]}/${base_name}.log"
    seed="${base_name##*-s}"

    # Construct clingo strategy options
    if [ $parallel_threads -eq 1 ]; then
        config_opts=" --configuration=trendy --seed=$seed"
    else
        config_opts=" -t $parallel_threads"
    fi

    # Generate SLURM batch script
    slurm_script="${slurm_dir_map[$key]}/${base_name}.sh"

    cat <<EOF > "$slurm_script"
#!/bin/bash
#============ Slurm Options ============
#SBATCH -p gr10609b
#SBATCH -t 1:10:00
#SBATCH --rsc p=1:t=8:c=8:m=16384M
#SBATCH -J ${strategy}-${base_name}
#SBATCH -o ${slurm_dir_map[$key]}/${base_name}.out
#SBATCH -e ${slurm_dir_map[$key]}/${base_name}.err

#============ Shell Script ============
set -x

# Solve the instance
srun ../bin/nspsolver.py $encoding $inst $requests_file -i $old_model_file $strategy_options -o $new_model_file $area_setting $options $config_opts --stats > $log_file 2>&1
EOF

    echo "SLURM script generated: $slurm_script"
}

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Loop through all instances
for inst in instances/nsp-*.lp; do

    # Loop for each strategy
    for key in "${!out_dir_map[@]}"; do
        process_instance $inst $key
    done

done
