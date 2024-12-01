! https://www.dartmouth.edu/~rc/classes/intro_openmp/hello_world_openmp.html
!1.Set the number of threads
!  $ export OMP_NUM_THREADS=5
!2.Compile and Run:
!  $ gfortran -o out -fopenmp example_0_OpenMP_Hello_world.f90
!3.Execute: 
!  $ ./out

PROGRAM HELLO
   INTEGER NTHREADS, TID, OMP_GET_NUM_THREADS, OMP_GET_THREAD_NUM
 
! Fork a team of threads giving them their own copies of variables
   !$OMP PARALLEL PRIVATE(NTHREADS, TID)

! Obtain thread number
   TID = OMP_GET_THREAD_NUM()
   PRINT *, 'Hello World from thread = ', TID

! Only master thread does this
   IF (TID .EQ. 0) THEN
       NTHREADS = OMP_GET_NUM_THREADS()
       PRINT *, 'Number of threads = ', NTHREADS
   END IF

! All threads join master thread and disband
  !$OMP END PARALLEL

 END

