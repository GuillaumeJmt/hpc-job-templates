#!/bin/bash
# Session interactive pour débugger un job sur un vrai nœud de calcul
# Usage : bash interactive-debug.sh
#
# Equivalent de :
# srun --nodes=1 --ntasks=1 --cpus-per-task=4 --mem=8G --time=01:00:00 --pty bash

srun \
  --nodes=1 \
  --ntasks=1 \
  --cpus-per-task=4 \
  --mem=8G \
  --time=01:00:00 \
  --partition=batch \
  --job-name=interactive \
  --pty bash

# Une fois connecté au nœud :
# - tester tes commandes manuellement
# - vérifier que tes modules chargent
# - mesurer la mémoire réelle avec /usr/bin/time -v ./programme
