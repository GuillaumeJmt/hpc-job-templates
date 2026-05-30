#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --nodes=2                     # 2 nœuds de calcul
#SBATCH --ntasks=32                   # 32 processus MPI au total
#SBATCH --ntasks-per-node=16          # 16 processus par nœud
#SBATCH --cpus-per-task=1             # 1 CPU par processus MPI (pur MPI)
#SBATCH --mem-per-cpu=2G              # Mémoire par CPU
#SBATCH --time=04:00:00
#SBATCH --partition=batch
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

module purge
module load OpenMPI/4.1.4-GCC-11.3.0  # Toolchain foss typique CECI

echo "Job started: $(date)"
echo "Nodes: $SLURM_JOB_NODELIST"
echo "Total MPI ranks: $SLURM_NTASKS"

# srun est préféré à mpirun sur Slurm
srun ./mon_programme_mpi

echo "Job finished: $(date)"
