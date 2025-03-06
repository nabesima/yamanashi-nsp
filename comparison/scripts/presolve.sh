#!/bin/bash

solve_limit=""
time_limit=""
parallel_threads=1
out_dir="presolved"  # Default output directory

# Parse command line arguments using getopts
while getopts ":l:t:p:o:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            time_limit=${OPTARG}
            ;;
        p)
            parallel_threads=${OPTARG}
            ;;
        o)
            out_dir=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-p parallel_threads] [-o out_dir]"
            exit 1
            ;;
    esac
done

# Construct nspsolver options
options=""
if [[ -n "$solve_limit" ]]; then
    options+=" --solve-limit=$solve_limit"
fi
if [[ -n "$time_limit" ]]; then
    options+=" --timeout $time_limit"
fi

# Enable debugging and strict error handling
export PS4='+ [Elapsed: ${SECONDS}s] [Line $LINENO] '
set -euxo pipefail

# Create the output directory
mkdir -p "$out_dir"

slurm_script_dir="tmp-$out_dir"
mkdir -p "$slurm_script_dir"

# Function to process an individual instance
process_instance() {
    inst="$1"
    echo "Processing instance: $inst"
    base_name="$(basename "$inst" .lp)"
    model="$out_dir/${base_name}.model"
    log_file="$out_dir/${base_name}.log"
    seed="${base_name##*-s}"

    if [ $parallel_threads -eq 1 ]; then
        config_opts=" --configuration=trendy --seed=$seed"
    else
        config_opts=" -t $parallel_threads"
    fi

    # Generate SLURM batch script
    slurm_script="${slurm_script_dir}/${base_name}.sh"

    cat <<EOF > "$slurm_script"
#!/bin/bash
#============ Slurm Options ============
#SBATCH -p gr10609b
#SBATCH -t 1:10:00
#SBATCH --rsc p=1:t=8:c=8:m=16384M
#SBATCH -J ${base_name}
#SBATCH -o ${slurm_script_dir}/${base_name}.out
#SBATCH -e ${slurm_script_dir}/${base_name}.err

#============ Shell Script ============
set -x

# Solve the instance with specified solve limit
srun ../bin/nspsolver.py ../encoding/nsp.lp "$inst" -o "$model" $options $config_opts --stats > "$log_file" 2>&1
EOF

    echo "SLURM script generated: $slurm_script"
}

# Process all instances
for inst in instances/*.lp; do
    process_instance "$inst"
done