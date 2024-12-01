!
!********************************************************************
!
!	C-DAC Tech Workshop : hyPACK-2013
!              October 15-18, 2013
!
!   Example 2 : Mpi-Omp_PI_Calculation.f
!
!   Objective : Write an Mpi-OpenMP program to compute the value of pi
!               function by numerical integration of a function
!               f(x) = 4/(1+x*x ) between the limits 0 and 1.
!
!               This example demonstrates the use of
!                         MPI_Init
!		          MPI_Comm_rank
!		          MPI_Comm_size
!		          MPI_Bcast
!		          MPI_Reduce
!		          MPI_Finalize and
!               PARALLEL DO directive, CRITICAL section and 
!               PRIVATE and SHARED clauses
!
!   Input     : Number of intervals
!
!   Output    : Processor with rank 0 prints the computed value of PI
!
!   Created   : August-2013
!
!   E-mail    : hpcfte@cdac.in     
!
!*********************************************************************

      program PiComputation

       include "mpif.h"

       double precision  PI25DT
       parameter        (PI25DT = 3.141592653589793238462643d0)

       double precision  mypi, pi, h, x, f, a
       integer n, MyRank, Numprocs, i, rc

       integer Start, End
       double precision LocalSum

!                                 function to integrate
       f(a) = 4.d0 / (1.d0 + a*a)
 
       call MPI_INIT( ierr )
       call MPI_COMM_RANK( MPI_COMM_WORLD, MyRank, ierr )
       call MPI_COMM_SIZE( MPI_COMM_WORLD, Numprocs, ierr )
       print *, 'Process ', MyRank, ' of ', Numprocs, ' is alive'
 
       sizetype   = 1
       sumtype    = 2
 
       do 
          if ( MyRank .eq. 0 ) then
             write(6,98)
 98    format('Enter the number of intervals: (0 quits)')
       read(5,99) NoofIntervals
 99    format(i10)
          endif
      
          call MPI_BCAST(NoofIntervals,1,MPI_INTEGER,0,
     *                    MPI_COMM_WORLD,ierr)

!                                 check for quit signal
          if ( NoofIntervals .le. 0 ) exit

          if(mod(NoofIntervals, Numprocs) .ne. 0) then
            print*,"Noof Intervals are not divisible by number of procs", Numprocs
            exit
          endif
!                                 calculate the interval size
          h = 1.0d0/NoofIntervals

          Start = MyRank*(NoofIntervals/Numprocs)
          End = (MyRank+1)*(NoofIntervals/Numprocs) - 1
          LocalSum  = 0.0d0

!$OMP PARALLEL DO PRIVATE(x) SHARED(LocalSum)
          do i = Start, End
             x = h * (dble(i) - 0.5d0)
!$OMP CRITICAL
             LocalSum = LocalSum + f(x)
!$OMP END CRITICAL
          enddo
          mypi = h * LocalSum

!                                 collect all the partial sums
          call MPI_REDUCE(mypi,pi,1,MPI_DOUBLE_PRECISION,MPI_SUM,0, 
     *                MPI_COMM_WORLD,ierr)

!                                 node 0 prints the answer.
          if (MyRank .eq. 0) then
              write(6, 97) pi, abs(pi - PI25DT)
 97     format('  pi is approximately: ', F18.16, 
     *         '  Error is: ', F18.16)
          endif

       enddo

       call MPI_FINALIZE(rc)
       stop
      end




