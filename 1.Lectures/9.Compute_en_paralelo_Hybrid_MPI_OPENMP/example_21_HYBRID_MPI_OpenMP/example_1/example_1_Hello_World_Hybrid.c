/*
 mpicc --version
 mpifor - version
 mpirun --version
 mpichversion
https://rcc.uchicago.edu/docs/running-jobs/hybrid/index.html

module load openmpi
The options are similar to running an MPI job, with some differences:

Compile :
mpicc -fopenmp -o out  example_1_Hello_World_Hybrid.c

--np = 4 specifies the number of MPI processes (“tasks”).
OMP_NUM_THREADS = 8 allocates 8 CPUs for each task.

Set Envirorment
export OMP_NUM_THREADS = 2

Execute:
mpirun -np 4 ./out

Hello from thread 0 out of 2 from process 0 out of 4 on Fiona
Hello from thread 1 out of 2 from process 0 out of 4 on Fiona
Hello from thread 0 out of 2 from process 2 out of 4 on Fiona
Hello from thread 1 out of 2 from process 2 out of 4 on Fiona
Hello from thread 0 out of 2 from process 3 out of 4 on Fiona
Hello from thread 0 out of 2 from process 1 out of 4 on Fiona
Hello from thread 1 out of 2 from process 3 out of 4 on Fiona
Hello from thread 1 out of 2 from process 1 out of 4 on Fiona
 */

#include <stdio.h>

/* Include MPI and OpenMP Header File */
#include <omp.h>
#include "mpi.h"

int main(int argc, char *argv[]) {
  int numprocs, rank, namelen;
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int thead_id = 0, nthreads = 1;
  
/* Initialize MPI Environment */
  MPI_Init(&argc, &argv);
  
/* Get the total number of processors. I am asking for */  
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
  
/* Get current process ID number (rank) */
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
 
/* Get the name of this processor (usually the hostname) */  
  MPI_Get_processor_name(processor_name, &namelen);

  #pragma omp parallel default(shared) private(thead_id, nthreads)
  {
    nthreads = omp_get_num_threads();
    thead_id = omp_get_thread_num();
    printf("Hello from thread %d out of %d from process %d out of %d on %s\n",
           thead_id, nthreads, rank, numprocs, processor_name);
  }
  
/* End MPI Environment */
  MPI_Finalize();
}
