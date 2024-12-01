// https://docs.rc.fas.harvard.edu/kb/hybrid-mpiopenmp-codes-on-odyssey/
//  mpicxx -o hybrid_test.x hybrid_test.cpp -openmp
// export OMP_NUM_THREADS=4
// srun -n 2 --cpus-per-task=4 --mpi=pmix ./hybrid_test.x
//==========================================================
//  Program: hybrid_test.cpp (MPI + OpenMP)
//           C++ example - program prints out
//           rank of each MPI process and OMP thread ID
//==========================================================
#include <iostream>
#include <mpi.h>
#include <omp.h>
using namespace std;
int main(int argc, char** argv){
  int iproc;
  int nproc;
  int i;
  int j;
  int nthreads;
  int tid;
  int provided;
  MPI_Init_thread(&argc,&argv, MPI_THREAD_MULTIPLE, &provided);
  MPI_Comm_rank(MPI_COMM_WORLD,&iproc);
  MPI_Comm_size(MPI_COMM_WORLD,&nproc);
#pragma omp parallel private( tid )
  {
    tid = omp_get_thread_num();
    nthreads = omp_get_num_threads();
    for ( i = 0; i <= nproc - 1; i++ ){
      MPI_Barrier(MPI_COMM_WORLD);
      for ( j = 0; j <= nthreads - 1; j++ ){
        if ( (i == iproc) && (j == tid) ){
          cout << "MPI rank: " << iproc << " with thread ID: " << tid << endl;
        }
      }
    }
  }
  MPI_Finalize();
  return 0;
}
