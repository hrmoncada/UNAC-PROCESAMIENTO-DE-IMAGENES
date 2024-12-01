/* https://stackoverflow.com/questions/35246774/hello-world-c-program-using-hybrid-of-openmp-and-mpi

I am using a dual-processor Xeon workstation (2x6 cores) running Ubuntu 12.10.
I have no trouble getting programs that use MPI or OpenMP (but not both) to work.

Compiled the source above using the command
$ mpicc -fopenmp -o out example_4_Hello_World_Hybrid.c 

Execute
$ export OMP_NUM_THREADS=4
$ mpirun -np 2 ./out -x OMP_NUM_THREADS
 */
#include <stdio.h>
#include <mpi.h>
#include <omp.h>

int main(int argc, char *argv[]) {
  int numprocs, rank, namelen;
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int iam = 0, np = 1;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Get_processor_name(processor_name, &namelen);

  //omp_set_num_threads(4);

#pragma omp parallel default(shared) private(iam, np)
  {
    np = omp_get_num_threads();
    iam = omp_get_thread_num();
    printf("Hello from thread %d out of %d from process %d out of %d on %s\n",
           iam, np, rank, numprocs, processor_name);
  }

  MPI_Finalize();
}
