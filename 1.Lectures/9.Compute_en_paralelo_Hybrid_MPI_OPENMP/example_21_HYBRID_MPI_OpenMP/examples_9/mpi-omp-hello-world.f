!
!*************************************************************************
!
!	C-DAC Tech Workshop : hyPACK-2013
!            October 15-18, 2013
!
!   Example 1 : Mpi-Omp_Hello_World.f90
!
!  Objective  : MPI-OpenMP program to print "Hello World"
!
!               This example demonstrates the use of
!	            MPI_Init
!	            MPI_Comm_rank
!	            MPI_Comm_size
!              MPI_Finalize and 
!              OpenMP PARALLEL PRIVATE directive and 
!              run-time library routine OMP_GET_THREAD_NUM
!
!  Input     : 
!
!  Output    : Each thread from each processor prints the Hello World Message
!              and Rank of the process and thread identifier. 
!
!   Created  : August-2013
!
!   E-mail   : hpcfte@cdac.in     
!
!**************************************************************************

C         SUBROUTINE OMP_SET_NUM_THREADS (NUM_THREADS)
C         INTEGER NUM_THREADS
C         END SUBROUTINE OMP_SET_NUM_THREADS

         program HelloWorld
!   USE mpi

         include "mpif.h"

          integer  MyRank, Numprocs
          integer  status(MPI_STATUS_SIZE)
         integer ThreadID, OMP_GET_THREAD_NUM

!.........MPI initialization.... 

         call MPI_INIT(ierror)
         call MPI_COMM_SIZE(MPI_COMM_WORLD, Numprocs, ierror)
         call MPI_COMM_RANK(MPI_COMM_WORLD, MyRank, ierror)

C         CALL OMP_SET_NUM_THREADS(10) 
!$OMP PARALLEL PRIVATE(ThreadID)

        ThreadID = OMP_GET_THREAD_NUM()

        print*,"Hello World From Process", MyRank,"Thread", ThreadID

!$OMP END PARALLEL

         call MPI_FINALIZE( ierror )

         stop
         end



