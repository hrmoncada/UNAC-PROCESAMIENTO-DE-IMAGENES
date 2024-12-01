#!/bin/bash

# A job submission script for running a hybrid MPI/OpenMP job on Midway2.

#SBATCH --job-name=hellohybrid
#SBATCH --output=hellohybrid.out
#SBATCH --ntasks=4               # specifies the number of MPI processes (“tasks”).
#SBATCH --cpus-per-task=8        # allocates 8 CPUs for each task.
#SBATCH --partition=broadwl
#SBATCH --constraint=edr

# Load the default OpenMPI module.
module load openmpi

# Set OMP_NUM_THREADS to the number of CPUs per task we asked for.
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Run the process with mpirun. Note that the -n option is not required
# in this case; mpirun will automatically determine how many processes
# to run from the Slurm settings.
mpirun ./hellohybrid
