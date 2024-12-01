!
!******************************************************************
!
!	C-DAC Tech Workshop : hyPACK-2013
!               October 15-18, 2013
!
! Example 3 : Mpi-Omp_Infinity_Norm_blkstp.f90
!
! Objective : Find Infinity norm of a matrix 
!	
! Input :
!      Real Matrix 
!      Read files (infndata.inp) for Matrix A
!
! Description : 
!      Input matrix is stored in n by n format.
!	    Rowwise block striped partitioning matrix is used. 
!      This example demonstrates the use of
!      PARALLEL DO directive, PRIVATE and SHARED clauses
!      and CRITICAL section
!
! Output : 
!
!     The infinity norm of matrix A on process with Rank 0
!
! Created   : August-2013
!
! E-mail    : hpcfte@cdac.in     
!
!*********************************************************************
!
!
C 

	 program InfinityNorm
	
	 include 'mpif.h'
 
         integer ROW_SIZE_A, COL_SIZE_A, TOTAL_SIZE_A

	 parameter (ROW_SIZE_A = 100, COL_SIZE_A = 100)
	 parameter (TOTAL_SIZE_A = ROW_SIZE_A*COL_SIZE_A)

! 	 ......Variables Initialisation ......
  	 integer n_size, NoofRows_Bloc, NoofRows, NoofCols
  	 integer Numprocs, MyRank, Root
  	 integer irow, icol, index, j, ValidOutput

  	 double precision Matrix_A(ROW_SIZE_A,COL_SIZE_A)
         double precision Input_A(TOTAL_SIZE_A)
	 double precision ARecv(TOTAL_SIZE_A),output(ROW_SIZE_A)
	 double precision infnorm, val_max
	 double precision Check_Output(ROW_SIZE_A), CheckSum, CheckMax

!	 ........MPI Initialisation .......
  	 call MPI_INIT(ierror) 
  	 call MPI_COMM_RANK(MPI_COMM_WORLD, MyRank, ierror)
  	 call MPI_COMM_SIZE(MPI_COMM_WORLD, Numprocs, ierror)
  
!	 .......Read the Matrix From Input file ......
	 Root = 0
	 if(MyRank .eq. Root) then
	   open(unit=12, file = './data/infndata.inp')
           read(12,*) NoofRows, NoofCols
           write(6,*) NoofRows, NoofCols
           do i = 1,NoofRows
              read(12,*) (Matrix_A(i,j), j=1,NoofCols)
              write(6, 75) (Matrix_A(i,j), j=1,NoofCols)
           enddo
 75	 format(8(2x,f8.3)/)
     	   n_size=NoofRows
	   close(12)

!	   ..... Convert Matrix_A into 1-D array Input_A ...
	  index = 1
	  do irow=1, n_size
	     do icol=1, n_size
		Input_A(index) = Matrix_A(irow, icol)
		index = index + 1
	     enddo
	  enddo
	endif

!   .... Broad cast the size of the matrix to all ....
	call MPI_BCAST(NoofRows, 1, MPI_INTEGER, Root, 
     *     	MPI_COMM_WORLD, ierror) 
  	call MPI_BCAST(NoofCols, 1, MPI_INTEGER, Root, 
     *          MPI_COMM_WORLD, ierror) 

  	if(NoofRows .ne. NoofCols) then
	   if(MyRank .eq. Root) then
     	     print*,"Input Matrix Should Be Square Matrix .."
           endif
	   goto 100
	endif

!	..... n_size = size of the square matrix
	if(MyRank .ne. Root) n_size = NoofRows
C        n_size = NoofRows
C        endif

  	if(mod(n_size, Numprocs) .ne. 0) then
	   if(MyRank .eq. 0) then
             print*,"Matrix Can not be Striped Evenly ..."
           endif
	   goto 100
	endif

  	NoofRows_Bloc = n_size/Numprocs

!  ......Scatter the Input Data to all process ......
  	call MPI_SCATTER (Input_A, NoofRows_Bloc * n_size,
     *       MPI_DOUBLE_PRECISION, ARecv, NoofRows_Bloc*n_size,
     *       MPI_DOUBLE_PRECISION, Root, MPI_COMM_WORLD,ierror)

!
!    Perform local rowwise maximum sum of absolute values of 
!    each row and accumlate local maximum 
!
      index = 0
!$OMP PARALLEL DO PRIVATE(sum, index,j) SHARED(val_max)
      do irow = 1, NoofRows_Bloc
	     index = (irow-1)*NoofCols 
        sum = 0.0
          do j = 1, NoofCols 
	       sum = sum + abs(ARecv(index+j))
          end do 
          output(irow) = sum
      end do

!     Accumalate local maximum on each process 
!
      val_max = output(1)
!$OMP CRITICAL
      do irow =1, NoofRows_Bloc
	     if(output(irow) .gt. val_max) val_max = output(irow)
      enddo
!$OMP END CRITICAL

!     .......Output vector .....
	call MPI_Reduce(val_max,infnorm,1,MPI_Real,MPI_Max, Root,
     *     		  MPI_COMM_WORLD, ierror)
	
	if(MyRank .eq. Root) then

      index = 0
      do irow = 1, NoofRows
	     index = (irow-1)*NoofCols 
        CheckSum = 0.0
          do j = 1, NoofCols 
	       CheckSum = CheckSum + abs(Input_A(index+j))
          end do 
          Check_Output(irow) = CheckSum
      end do

!     Accumalate local maximum on each process 
!
      Check_Max = Check_Output(1)
      do irow =1, NoofRows
	     if(Check_Output(irow) .gt. Check_Max) then
                 Check_Max = Check_Output(irow)
             endif
      enddo

      if(Check_Max .ne. infnorm) then
        ValidOutput = 0
      else
        ValidOutput = 1
      endif

      if(ValidOutput .eq. 1) then
        print*,"------ Correct Result -----"
      else
        print*,"------ Wrong Result -----"
      endif
      
      Print *, "Infinity Norm of Matrix ", infnorm

      endif

 100   call MPI_FINALIZE(ierror)

	stop
	end
!
!	********************************************************
!
!
