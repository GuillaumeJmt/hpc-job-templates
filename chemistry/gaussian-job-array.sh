#!/bin/bash
#SBATCH --job-name=gauss_array        # Nom du job
#SBATCH --array=1-10                  # 10 jobs identiques, indices 1 à 10
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=12:00:00
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%A_%a.out    # %A=array job ID, %a=task index
#SBATCH --error=logs/%x_%A_%a.err

# --- Principe du job array ---
# SLURM_ARRAY_TASK_ID prend les valeurs 1,2,...,10
# Chaque job traite une molécule différente

module purge
module load Gaussian/16-C.02

# --- Sélection du fichier input selon l'index ---
INPUT="molecules/molecule_${SLURM_ARRAY_TASK_ID}.gjf"
OUTPUT="results/molecule_${SLURM_ARRAY_TASK_ID}.log"

mkdir -p results

echo "Task ID: $SLURM_ARRAY_TASK_ID"
echo "Input: $INPUT"
echo "Started: $(date)"

g16 < $INPUT > $OUTPUT

echo "Finished: $(date)"
