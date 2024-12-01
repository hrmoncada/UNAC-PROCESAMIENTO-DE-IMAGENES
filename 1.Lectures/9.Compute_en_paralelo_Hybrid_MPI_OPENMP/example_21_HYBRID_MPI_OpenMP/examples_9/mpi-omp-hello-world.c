
/**********************************************************************
		C-DAC Tech Workshop : hyPACK-2013
                        October 15-18, 2013

   Example 1    :    Mpi-Omp_Hello_World.c

   Objective    : MPI-OpenMP program to print "Hello World"
                  This example demonstrates the use of
                  MPI LIBRARY CALLS and OPENMP Directives

   Input        : No Input is Required 

   Output       : Each thread created by each processor prints
                  Hello World along with its threadid and procesor rank.

   Created      : August-2013

   E-mail       : hpcfte@cdac.in     

**********************************************************************/

#include <stdio.h>
#include <omp.h>
#include <mpi.h>

/* Main Program */

main(int argc, char **argv)
{
	int             Numprocs, MyRank, iam;

	/* MPI - Initialization */

	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &MyRank);
	MPI_Comm_size(MPI_COMM_WORLD, &Numprocs);

	/* OpenMP Parallel Directive */
omp_set_num_threads(4); 
#pragma omp parallel private(iam)
	{
		iam = omp_get_thread_num();
		printf("Hello World is Printed By Process %d and Threadid %d\n", MyRank, iam);
	}

	/* MPI - Termination */
	MPI_Finalize();
}
