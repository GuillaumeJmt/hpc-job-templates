#!/bin/bash
#SBATCH --job-name=python_sci
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4             # numpy/scipy utilisent des threads internes
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

module purge
module load Python/3.11.3             # Module Python du cluster

# --- Environnement virtuel recommandé ---
# Créer une fois : python3 -m venv $HOME/envs/science
# Installer : pip install numpy scipy pandas matplotlib
source $HOME/envs/science/bin/activate

echo "Job started: $(date)"
echo "Python: $(python3 --version)"
echo "Node: $SLURMD_NODENAME"

# Limiter les threads internes numpy/scipy au nombre de CPUs alloués
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK

python3 mon_script.py

echo "Job finished: $(date)"
