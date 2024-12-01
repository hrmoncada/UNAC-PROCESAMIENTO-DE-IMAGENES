/*https://carleton.ca/rcs/documentation/introduction-to-openmp/
1.Set the number of threads
  $ export OMP_NUM_THREADS=5
2.Compile and Run:
  $ gcc -o out -fopenmp example_0_OpenMP_Hello_world.c
3.:Execute: 
  $ ./out
*/

#include <stdio.h>
#include <omp.h>    // openmp header

int main() {
    int thread_id;

/* Declares the scope of the data variables in list to be private to each thread.
 Data variables in list are separated by commas.  Fork a team of threads giving them
 their own copies of variables */    
    #pragma omp parallel private(thread_id)
    {
        thread_id = omp_get_thread_num();
        printf( "Hello, World from thread %d!\n", thread_id );
    }
    return 0;
}
