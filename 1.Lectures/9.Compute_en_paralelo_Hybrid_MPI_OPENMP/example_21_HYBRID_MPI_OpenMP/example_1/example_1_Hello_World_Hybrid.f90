! https://rcc.uchicago.edu/docs/running-jobs/hybrid/index.html
! module load openmpi
! The options are similar to running an MPI job, with some differences:
! 
! --np=4 specifies the number of MPI processes (“tasks”).
! OMP_NUM_THREADS=8 allocates 8 CPUs for each task.
! 
! Compile:
! $ mpif90 -fopenmp -o out example_1_Hello_World_Hybrid.f90 
! 
! Set Envirorment
! export OMP_NUM_THREADS=2
! 
! Execute
! $ mpirun -np 4 ./out
! 
! Hello from thread 0 out of 2 from process 0 out of 4 on lola
! Hello from thread 1 out of 2 from process 0 out of 4 on lola
! Hello from thread 0 out of 2 from process 1 out of 4 on lola
! Hello from thread 1 out of 2 from process 1 out of 4 on lola
! Hello from thread 0 out of 2 from process 2 out of 4 on lola
! Hello from thread 1 out of 2 from process 2 out of 4 on lola
! Hello from thread 0 out of 2 from process 3 out of 4 on lola
! Hello from thread 1 out of 2 from process 3 out of 4 on lola


program Hello_World
 ! Include OpenMP header file, invoke openmp functionality.
  use omp_lib
  
  implicit none
  
! Include MPI header file
  include 'mpif.h'

  integer*4 :: numprocs, rank, namelen, ierr
  character*(MPI_MAX_PROCESSOR_NAME) processor_name
  integer :: thead_id = 0, nthreads = 1
  
! Initialize MPI environment
   call mpi_init(ierr)

! Get the total number of processors. I am asking for
   call mpi_comm_size(mpi_comm_world, numprocs, ierr)

! Get current process id number (rank)
   call mpi_comm_rank(mpi_comm_world, rank, ierr)

! Get the name of this processor (usually the hostname)   
   call mpi_get_processor_name(processor_name, namelen, ierr);

!$omp parallel default(shared) private(thead_id, nthreads)
  nthreads = omp_get_num_threads()
  thead_id = omp_get_thread_num()
  print *,"Hello from thread ",thead_id," out of ",nthreads," from process ",rank,&
         " out of ",numprocs," on ", processor_name
!$omp end parallel
         
! End MPI environment
   call mpi_finalize(ierr) 

end program
