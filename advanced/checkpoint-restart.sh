#!/bin/bash
#SBATCH --job-name=long_calc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=48:00:00               # Job long — risque d'interruption
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

module purge
module load Gaussian/16-C.02

CHECKPOINT="calculation.chk"
INPUT="calculation.gjf"
OUTPUT="calculation.log"

echo "Job started: $(date)"

# --- Logique checkpoint/restart ---
if [ -f "$CHECKPOINT" ]; then
  echo "Checkpoint found — restarting from $CHECKPOINT"
  # Modifier l'input pour lire le checkpoint
  sed -i 's/#p opt/#p opt restart/' $INPUT
else
  echo "No checkpoint — starting fresh"
fi

g16 < $INPUT > $OUTPUT

echo "Job finished: $(date)"

# --- Vérifier si le calcul est converge ---
if grep -q "Normal termination" $OUTPUT; then
  echo "SUCCESS: calculation converged"
else
  echo "WARNING: check $OUTPUT for errors"
fi
