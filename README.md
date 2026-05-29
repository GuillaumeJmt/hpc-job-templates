# HPC Job Templates — Slurm

Annotated Slurm job scripts for scientific computing workflows on academic HPC clusters.

Developed from real experience running quantum chemistry calculations
(Gaussian, NWChem, Molpro) on academic clusters (CECI infrastructure).

## Contents

| Script | Use case | Parallelism |
|--------|----------|-------------|
| `basic/single-node-serial.sh` | Simple serial job | 1 CPU |
| `basic/single-node-parallel.sh` | Shared-memory parallel | OpenMP |
| `basic/interactive-debug.sh` | Debug session on compute node | — |
| `chemistry/gaussian-optimization.sh` | DFT geometry optimization | SMP |
| `chemistry/gaussian-job-array.sh` | Parameter sweep over molecules | Array |
| `python/python-scientific.sh` | Scientific Python workflow | — |
| `advanced/checkpoint-restart.sh` | Long job with restart | — |

## Key concepts

- Always `module purge` before loading modules
- Match `--ntasks` to your software's parallelism model
- Use `seff JOBID` after completion to check resource efficiency
- Check `sacct -j JOBID --format=MaxRSS` to calibrate memory requests

## Environment
Developed for CECI-compatible Slurm environments (Lemaitre4, Nic5 conventions).
