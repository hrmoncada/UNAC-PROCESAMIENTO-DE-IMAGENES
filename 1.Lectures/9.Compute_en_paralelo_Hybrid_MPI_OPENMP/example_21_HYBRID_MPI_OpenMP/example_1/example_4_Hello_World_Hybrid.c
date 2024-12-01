/* Entornos de programación paralela, Seminario de doctorado, UPV 2007
Programación híbrida, Domingo Giménez
Dpto. de Informática y Sistemas, Universidad de Murcia
http://dis.um.es/~domingo/apuntes/Valencia/0708/ProgHibrida.pdf
*/
#include <stdio.h>

/* Include MPI and OpenMP Header File */
#include <omp.h>
#include "mpi.h"


int main (int argc,char **argv) {
//Variables
    int i,load,begin,end,*a,n,l,u,x,keepon=1,position=­1,thread=­1;
    int nthreads,nprocs,idpro,idthr;
    int namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Status estado;

//Iniciación MPI
   MPI_Init(&argc,&argv);
   MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
   MPI_Comm_rank(MPI_COMM_WORLD,&idpro);
   MPI_Get_processor_name(processor_name,&namelen);

   if(idpro==0) { //Entrada y envío de datos
      printf("De el numero de datos del array: "); scanf("%d",&n);

      MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
      a = (int *) malloc(sizeof(double)*n);

      printf("De los valores minimo y maximo: "); scanf("%d %d",&l,&u);

      generar_enteros(a,n,l,u); escribir_enteros(a,n);

      printf("De el numero a buscar: "); scanf("%d",&x);
      MPI_Bcast(&x, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);

      for (i=1;i<nprocs;i++)
         MPI_Send(&a[i*n/nprocs],n/nprocs,MPI_INT,i,ENVIO_INICIAL, MPI_COMM_WORLD);
   } else { //Recepción de datos
      MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
      MPI_Bcast(&x, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
      a = (int *) malloc(sizeof(int)*n/nprocs);
      MPI_Recv(a,n/nprocs,MPI_INT,0,ENVIO_INICIAL,MPI_COMM_WORLD, &estado);
   }

//Puesta en marcha de los threads
   #pragma omp parallel private(idthr,i,load,begin,end)
   {
      #pragma omp master
           nthreads = omp_get_num_threads();
           idthr = omp_get_thread_num(); load = n/nprocs/nthreads;
           begin = idthr*load; end = begin+load;
           for (i = begin; ((i<end) && keepon); i++) {
               if (a[i] == x) {
                    keepon = 0; position = i; thread=idthr;
               }
               #pragma omp flush(keepon,position)
          } 
    }

   if (idpro==0) { //Recibir datos
      if (position!=­1)
         printf("Encontrado en la posicion %di, por el thread %d de %d, del proceso %d\n",position,thread,nthreads,idpro);
         for(i=1;i<nprocs;i++){
             MPI_Recv(&position,1,MPI_INT,i,ENVIO_FINAL,MPI_COMM_WORLD,&estado);
             MPI_Recv(&thread,1,MPI_INT,i,ENVIO_FINAL_THR,MPI_COMM_WORLD,&estado);
             MPI_Recv(&nthreads,1,MPI_INT,i,ENVIO_FINAL_NTHR,MPI_COMM_WORLD, &estado);
             if(position!=­1)
               printf("Encontrado en la posicion %d,por el tread %d de %d, del proceso %d\n",position+i*n/nprocs,thread,nthreads,i);
             }
      } else { //Enviar datos
         MPI_Send(&position,1,MPI_INT,0,ENVIO_FINAL,MPI_COMM_WORLD);
         MPI_Send(&thread,1,MPI_INT,0,ENVIO_FINAL_THR,MPI_COMM_WORLD);
         MPI_Send(&nthreads,1,MPI_INT,0,ENVIO_FINAL_NTHR,MPI_COMM_WORLD);
      } 
      MPI_Finalize(); 
}
