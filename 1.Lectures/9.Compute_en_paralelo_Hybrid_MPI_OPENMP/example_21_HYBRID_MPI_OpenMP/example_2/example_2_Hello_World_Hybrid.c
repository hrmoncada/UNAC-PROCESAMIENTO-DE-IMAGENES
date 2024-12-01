/*
https://gist.github.com/huzhifeng/d1cda3f0474261eda72b36ca83f24e21

module load openmpi
mpicc -fopenmp -o out  example_1_Hello_World_Hybrid.c

The options are similar to running an MPI job, with some differences:

--np=4 specifies the number of MPI processes (“tasks”).
OMP_NUM_THREADS=8 allocates 8 CPUs for each task.

export OMP_NUM_THREADS=8
mpirun -np 4 ./out
*/

#include <stdio.h>
#include <mpi.h>
#include <omp.h>

int main(int argc, char *argv[])
{
    int numprocs, rank, namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int iam = 0, np = 1;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Get_processor_name(processor_name, &namelen);

    #pragma omp parallel default(shared) private(iam, np)
    {
        np = omp_get_num_threads();
        iam = omp_get_thread_num();
        printf("Hybrid: Hello from thread %d out of %d from process %d out of %d on %s\n",
                iam, np, rank, numprocs, processor_name);
    }

    MPI_Finalize();

    return 0;
}
