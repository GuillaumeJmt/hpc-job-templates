#!/bin/bash
#SBATCH --job-name=gauss_opt          # Nom du job visible dans squeue
#SBATCH --nodes=1                     # 1 nœud de calcul
#SBATCH --ntasks=1                    # 1 processus (Gaussian est SMP, pas MPI)
#SBATCH --cpus-per-task=8             # 8 cœurs pour parallélisme partagé
#SBATCH --mem=16G                     # Mémoire totale demandée
#SBATCH --time=24:00:00               # Walltime maximum (HH:MM:SS)
#SBATCH --partition=batch             # Partition cible (adapter selon cluster)
#SBATCH --output=logs/%x_%j.out       # Fichier de sortie (%x=jobname, %j=jobID)
#SBATCH --error=logs/%x_%j.err        # Fichier d'erreur séparé
#SBATCH --mail-type=END,FAIL          # Notification email en fin ou échec
#SBATCH --mail-user=your@email.com    # Adresse de notification

# --- Environnement ---
module purge                          # Toujours purger avant de charger
module load Gaussian/16-C.02          # Charger Gaussian via le module system

# --- Variables ---
INPUT="molecule.gjf"                  # Fichier input Gaussian
OUTPUT="molecule.log"                 # Fichier output

# --- Scratch local ---
# Gaussian est très I/O intensif — utiliser le scratch local du nœud
SCRATCH=/scratch/$SLURM_JOB_USER/$SLURM_JOB_ID
mkdir -p $SCRATCH
export GAUSS_SCRDIR=$SCRATCH          # Variable Gaussian pour le scratch

# --- Calcul ---
echo "Job started: $(date)"
echo "Node: $SLURMD_NODENAME"
echo "CPUs: $SLURM_CPUS_PER_TASK"

g16 < $INPUT > $OUTPUT

echo "Job finished: $(date)"

# --- Nettoyage scratch ---
rm -rf $SCRATCH
