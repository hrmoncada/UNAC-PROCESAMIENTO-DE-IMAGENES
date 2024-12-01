!
!********************************************************************
!
!	C-DAC Tech Workshop : hyPACK-2013
!             October 15-18, 2013
!
!Example 4 : Mpi-Omp_MatVect_Mult_blkstp.f90
!
!Objective  : Matrix Vector Multiplication using block-striped partitioning
!	
!Description : 
!      Input matrix is stored in n by n format.
!	    Rowwise block striped partitioning matrix is used. 
!      This example demonstrates the use of
!      PARALLEL DO directive and CRITICAL section
!
!Input :
!        Real square Matrix and the real vector - Matrix_A and Vector_B
!        Read files (mdata.inp) for Matrix A and (vdata.inp) for Vector b
!
!Output : 
!      Process 0 prints the result of Matrix_Vector Multiplication
!
!Created : August-2013
!
!E-mail  : hpcfte@cdac.in     
!
!
!*******************************************************************
!
        program MatVectMultBlockStriped

        include 'mpif.h'

        integer ROW_SIZE_A, COL_SIZE_A, ROW_SIZE_B, TOTAL_SIZE_A
        parameter (ROW_SIZE_A = 100, COL_SIZE_A = 100)
        parameter (ROW_SIZE_B = COL_SIZE_A)
        parameter (TOTAL_SIZE_A = ROW_SIZE_A*COL_SIZE_A)

! 	 ......Variables Initialisation ......
        integer n_size, NoofRows_Bloc, NoofRows, NoofCols
        integer NoofVectRows
        integer Numprocs, MyRank, Root
        integer irow, icol, index, ValidOutput


        double precision Matrix_A(ROW_SIZE_A, COL_SIZE_A)
        double precision Input_A(TOTAL_SIZE_A), My_Matrix(ROW_SIZE_A)
        double precision Vector_B(ROW_SIZE_B)
        double precision MyOutput_Vector(ROW_SIZE_B)
        double precision Output_Vector(ROW_SIZE_B)
        double precision sum, Check_C(ROW_SIZE_B)

!	 ........MPI Initialisation .......
        call MPI_INIT(ierror) 
        call MPI_COMM_RANK(MPI_COMM_WORLD, MyRank, ierror)
        call MPI_COMM_SIZE(MPI_COMM_WORLD, Numprocs, ierror)
  
!	 .......Read the Matrix From Input file ......
        Root = 0
        if(MyRank .eq. Root) then
        open(unit=12, file = './data/mdata.inp')
          read(12,*) NoofRows, NoofCols
          print*,"Matrix A"
          write(6,*) NoofRows, NoofCols

          do i = 1, NoofRows
             read(12,*) (Matrix_A(i,j), j = 1,NoofCols)
             write(6, 75) (Matrix_A(i,j),j = 1,NoofCols)
          enddo
 75	    format(8(2x,f8.3)/)
!
!    ....... Read vector from input file .......
	   open(unit=13, file = './data/vdata.inp')
          read(13,*) NoofVectRows
          read(13,*) (Vector_B(i), i = 1, NoofVectRows)
          print*,"Vector"
          write(6, 75) (Vector_B(i),i = 1, NoofVectRows)
	   close(12)
	   close(13)

!	   ..... Convert Matrix_A into 1-D array Input_A ...
	  index = 1
	  do irow=1, NoofRows
	     do icol=1, NoofCols
		Input_A(index) = Matrix_A(irow, icol)
		index = index + 1
	     enddo
	  enddo
!
	endif

!   .... Broadcast the number of rows and columns of the matrix to all 
	call MPI_BCAST(NoofRows, 1, MPI_INTEGER, Root,
     *     	               MPI_COMM_WORLD, ierror) 
  	call MPI_BCAST(NoofCols, 1, MPI_INTEGER, Root,
     *     		       MPI_COMM_WORLD, ierror) 
  	call MPI_BCAST(NoofVectRows, 1, MPI_INTEGER, Root,
     *     		       MPI_COMM_WORLD, ierror) 

  	if(NoofRows .ne. NoofCols) then
	   if(MyRank .eq. Root) then 
              print*,"Input Matrix is not Square Matrix - Exist."
	   endif
	   goto 100
	endif

  	if(NoofCols .ne. NoofVectRows) then
	   if(MyRank .eq. Root)  then
             print*," Matrix can not be multiplied with vector - Exist"
	   endif
	   goto 100
	endif

!        .... Size of the square matrix available to all process 
     	n_size = NoofRows
  	if(mod(n_size, Numprocs) .ne. 0) then
	  if(MyRank .eq. 0) then
             print*,"Matrix Can not be Striped Evenly - exist..."
	  endif
	   goto 100
	endif

  	NoofRows_Bloc = n_size/Numprocs

!  ......Scatter the Input Data (Matrix) stored in the form 
!        of one dimensional array to all process
!
  	call MPI_SCATTER (Input_A, NoofRows_Bloc * n_size, 
     *        MPI_DOUBLE_PRECISION, My_Matrix, NoofRows_Bloc*n_size, 
     * 	     MPI_DOUBLE_PRECISION, Root, MPI_COMM_WORLD,ierror)

  	call MPI_BCAST(Vector_B, NoofVectRows, MPI_DOUBLE_PRECISION, 
     *       Root, MPI_COMM_WORLD, ierror) 
!
!    Perform local rowwise matrix-vector multipication on each row
!    and accumlate partial vector values 
!

!$OMP PARALLEL DO PRIVATE (index, icol)
      	   do irow = 1, NoofRows_Bloc
	      index = (irow-1) * NoofCols 

	      sum = 0.0
	      do icol = 1, NoofCols 
	 	 sum = sum + Vector_B(icol)*My_Matrix(index+icol)
	      enddo

	      MyOutput_Vector(irow) =  sum
	   enddo

!     ........Gather output vector on the processor 0 
  	   call MPI_GATHER(MyOutput_Vector, NoofRows_Bloc, 
     * 		MPI_DOUBLE_PRECISION, Output_Vector, NoofRows_Bloc, 
     *   	MPI_DOUBLE_PRECISION, Root, MPI_COMM_WORLD, ierror)

!	.......Output vector .....
	if (MyRank .eq. Root) then
         print*,"Output Vector"
	   write(6, 75) (Output_Vector(irow), irow=1, n_size)

      do i = 1, NoofRows
        Check_C(i) = 0.0
        do j = 1, NoofCols
          Check_C(i) = Check_C(i) + (Matrix_A(i,j) * Vector_B(i))
        enddo
      enddo

      do i = 1, n_size
         if(Output_Vector(i) .ne. Check_C(i)) then
            ValidOutput = 0
         else
            ValidOutput = 1
         endif
      enddo

      if(ValidOutput .eq. 1) then
        print*,"------ Correct Result -----"
      else
        print*,"------ Wrong Result -----"
      endif
	endif
  
 100    call MPI_FINALIZE(ierror)

	stop
	end
!
!	********************************************************
!


