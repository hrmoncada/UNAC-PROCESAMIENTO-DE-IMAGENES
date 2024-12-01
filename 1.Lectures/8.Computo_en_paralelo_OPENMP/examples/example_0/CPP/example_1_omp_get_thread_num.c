/*
1.Set the number of threads
  $ export OMP_NUM_THREADS=5
2.Compile and Run:
g++ -o out -fopenmp example_1_omp_get_thread_num.c
3. Execute: 
  $ ./out
*/

#include <stdio.h>
#include <omp.h>

int main() {
   int max = omp_get_max_threads();
   printf("omp_get_max_threads = %i\n", max);

   #pragma omp parallel
   {
      int t = omp_get_thread_num();
      printf(" omp_get_thread_num = %i\n", t);
   }
   return 0;
}

