/* https://www.dartmouth.edu/~rc/classes/intro_openmp/hello_world_openmp.html
1.Set the number of threads
  $ export OMP_NUM_THREADS=5
2.Compile and Run:
  $ gcc -o out -fopenmp example_1_OpenMP_Hello_world.c
3. Execute: 
  $ ./out

*/
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {

   int nthreads, tid;

/*Declares the scope of the data variables in list to be private to each thread.
 Data variables in list are separated by commas. Fork a team of threads giving them 
 their own copies of variables */
   #pragma omp parallel private(nthreads, tid)
   {

 /* Obtain thread number */
    tid = omp_get_thread_num();
    printf("Hello World from thread = %d\n", tid);

 /* Only master thread does this */
    if (tid == 0) {
       nthreads = omp_get_num_threads();
       printf("Number of threads = %d\n", nthreads);
    }

    } /* All threads join master thread and disband */

}
