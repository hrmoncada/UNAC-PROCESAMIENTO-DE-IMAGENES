/* Entornos de programación paralela, Seminario de doctorado, UPV 2007
Programación híbrida, Domingo Giménez
Dpto. de Informática y Sistemas, Universidad de Murcia
http://dis.um.es/~domingo/apuntes/Valencia/0708/ProgHibrida.pdf
*/

#include <stdio.h>

/* Include MPI and OpenMP Header File */
#include <omp.h>
#include "mpi.h"

int main(int argc, char *argv[]) {
   int nthreads,nprocs,idpro,idthr; int namelen;
   char processor_name[MPI_MAX_PROCESSOR_NAME];

   MPI_Init(&argc,&argv);
   MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
   MPI_Comm_rank(MPI_COMM_WORLD,&idpro);
   MPI_Get_processor_name(processor_name,&namelen);

  #pragma omp parallel private(idthr) firstprivate(idpro,processor_name) {
     idthr = omp_get_thread_num();
     printf("... thread %d, proceso %d procesador %s\n",idthr,idpro,processor_name);
     if (idthr == 0) {
        nthreads = omp_get_num_threads();
        printf(" proceso %d, threads %d, procesos %d\n",idpro,nthreads,nprocs);
     }
  }

  MPI_Finalize(); 
  return 0;
}
