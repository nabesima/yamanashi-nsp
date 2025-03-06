#!/bin/bash

past_dir="tmp-past"
curr_dir="tmp-curr"
output_dir="instances"
slurm_script_dir="tmp-make-instances"
base_date="2025-09-08"
solve_limit=""
time_limit=""

# Parse command line arguments using getopts
while getopts ":l:t:s:" opt; do
    case ${opt} in
        l)
            solve_limit=${OPTARG}
            ;;
        t)
            time_limit=${OPTARG}
            ;;
        s)
            slurm_script_dir=${OPTARG}
            ;;
        *)
            echo "Usage: $0 [-l solve_limit] [-t time_limit] [-s slurm_script_dir]"
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
mkdir -p "$output_dir"
mkdir -p "$slurm_script_dir"

# Function to process an individual instance
process_instance() {
    past_inst="$1"
    echo "Processing instance: $past_inst"
    base_name="$(basename "$past_inst" .lp)"
    model="$past_dir/${base_name}.model"
    past_shift="$past_dir/${base_name}.past"
    log_file="$past_dir/${base_name}.log"
    seed="${base_name##*-s}"

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

# Solve the past instance with specified solve limit
srun ../bin/nspsolver.py ../encoding/nsp.lp "$past_inst" -o "$model" $options --configuration=trendy --seed=$seed --stats > "$log_file" 2>&1

# Generate past shift data
../bin/model2pastshift.py "$model" > "$past_shift"

# Concatenate the current instance and the past shift data
curr_inst="$curr_dir/${base_name}.lp"
output_inst="${output_dir}/${base_name}.lp"

if [ -f "\$curr_inst" ]; then
    cat "\$curr_inst" "$past_shift" > "\$output_inst"
else
    echo "Warning: \$curr_inst not found, skipping concatenation."
fi
EOF

    echo "SLURM script generated: $slurm_script"
}

# Loop through all .lp files in past_dir
for past_inst in "$past_dir"/*.lp; do
    process_instance "$past_inst"
done
