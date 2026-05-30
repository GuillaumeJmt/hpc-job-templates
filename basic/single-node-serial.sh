#!/bin/bash
#SBATCH --job-name=serial_job         # Nom du job
#SBATCH --nodes=1                     # 1 seul nœud
#SBATCH --ntasks=1                    # 1 seul processus
#SBATCH --cpus-per-task=1             # 1 CPU — job purement séquentiel
#SBATCH --mem=4G                      # Mémoire demandée
#SBATCH --time=02:00:00               # Walltime maximum
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

module purge

echo "Job started: $(date)"
echo "Node: $SLURMD_NODENAME"

# Lancer ton programme séquentiel
./mon_programme

echo "Job finished: $(date)"

# Après le job, vérifier l'efficacité :
# sacct -j $SLURM_JOB_ID --format=JobID,CPUTime,MaxRSS,Elapsed
