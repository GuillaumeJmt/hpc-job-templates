#!/bin/bash
#SBATCH --job-name=openmp_job
#SBATCH --nodes=1                     # 1 nœud — mémoire partagée
#SBATCH --ntasks=1                    # 1 processus
#SBATCH --cpus-per-task=16            # 16 threads OpenMP
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

module purge
module load GCC/11.3.0

# --- Variable OpenMP ---
# OMP_NUM_THREADS doit correspondre à --cpus-per-task
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

echo "Job started: $(date)"
echo "OpenMP threads: $OMP_NUM_THREADS"

./mon_programme_openmp

echo "Job finished: $(date)"
