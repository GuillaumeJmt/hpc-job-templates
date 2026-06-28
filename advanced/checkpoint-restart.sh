#!/bin/bash
#SBATCH --job-name=long_calc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --partition=batch
#SBATCH --signal=B:USR1@600
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

# Long Gaussian optimization with checkpoint-based restart.
# Requires the input to contain a %chk line (e.g. %chk=calculation.chk).
# Restart uses the route 'opt=restart' (NOT a bare 'restart'): it resumes the
# optimization from the .chk geometry and force constants.

module purge
module load Gaussian/16-C.02
mkdir -p logs

CHK="calculation.chk"
FRESH_INPUT="calculation.gjf"            # route: # opt freq ...        ; %chk=calculation.chk
RESTART_INPUT="calculation_restart.gjf"  # route: # opt=restart freq ... ; %chk=calculation.chk
OUTPUT="calculation.log"

# On walltime signal, requeue so Slurm restarts and auto-detects the .chk.
trap 'echo "Walltime signal: requeuing"; scontrol requeue "$SLURM_JOB_ID"; exit 0' USR1

if [[ -f "$CHK" ]]; then
  echo "Checkpoint found -> resuming with opt=restart"
  INPUT="$RESTART_INPUT"
else
  echo "No checkpoint -> fresh start"
  INPUT="$FRESH_INPUT"
fi

g16 < "$INPUT" > "$OUTPUT"

if grep -q "Normal termination" "$OUTPUT"; then
  echo "SUCCESS: calculation converged"
else
  echo "WARNING: not converged, check $OUTPUT"
fi
