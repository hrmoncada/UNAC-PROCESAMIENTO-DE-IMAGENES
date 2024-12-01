! https://docs.rc.fas.harvard.edu/kb/hybrid-mpiopenmp-codes-on-odyssey/
! mpif90 -o hybrid_test.x hybrid_test.f90 -fopenmp
! export OMP_NUM_THREADS=4
! srun -n 2 --cpus-per-task=4 --mpi=pmix ./hybrid_test.x
!=====================================================
! Program: hybrid_test.f90 (MPI + OpenMP)
!          FORTRAN 90 example - program prints out
!          rank of each MPI process and OMP thread ID
!=====================================================
program hybrid_test
  implicit none
  include "mpif.h"
  integer(4) :: ierr
  integer(4) :: iproc
  integer(4) :: nproc
  integer(4) :: icomm
  integer(4) :: i
  integer(4) :: j
  integer(4) :: nthreads
  integer(4) :: tid
  integer(4) :: omp_get_num_threads
  integer(4) :: omp_get_thread_num
  call MPI_INIT(ierr)
  icomm = MPI_COMM_WORLD
  call MPI_COMM_SIZE(icomm,nproc,ierr)
  call MPI_COMM_RANK(icomm,iproc,ierr)
!$omp parallel private( tid )
  tid = omp_get_thread_num()
  nthreads = omp_get_num_threads()
  do i = 0, nproc-1
     call MPI_BARRIER(icomm,ierr)
     do j = 0, nthreads-1
        !$omp barrier
        if ( iproc == i .and. tid == j ) then
           write (6,*) "MPI rank:", iproc, " with thread ID:", tid
        end if
     end do
  end do
!$omp end parallel
  call MPI_FINALIZE(ierr)
  stop
end program hybrid_test
