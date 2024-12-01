       program main
       use omp_lib
       include 'mat-mat.inc'

       integer DEBUG
       parameter (DEBUG=1)
       double precision EPS
       parameter (EPS=1.0e-18)

!       double precision  A(NN, NN)
!       double precision  B(NN, NN)
!       double precision  C(NN, NN)

       double precision,allocatable,dimension(:,:):: A, B, C

       double precision  t0, t1, t2, t_w
       double precision  d_mflops, dtemp
    
       integer  i, j, k, n
       integer  iflag, iflag_t


       allocate (A(NN,NN))
       allocate (B(NN,NN))
       allocate (C(NN,NN))

c      === matrix generation --------------------------
       if (DEBUG .eq. 1) then
          do j=1, NN
            do i=1, NN
              A(i, j) = 1.0;
              B(i, j) = 1.0;
              C(i, j) = 0.0;
            enddo
          enddo
       else 
          call RANDOM_SEED
          do j=1, NN
            do i=1, NN
              call RANDOM_NUMBER(dtemp)   
              A(i, j) = dtemp
              call RANDOM_NUMBER(dtemp)   
              B(i, j) = dtemp
              C(i, j) = 0.0
            enddo
          enddo
       endif
c      === end of matrix generation ------------------------

c      === Start of mat-vec routine ----------------------------
       t1 = omp_get_wtime()

       call MyMatMat(C, A, B, NN)

       t2 = omp_get_wtime()
       t_w =  t2 - t1 
c      === End of mat-vec routine ---------------------------


         print *, "NN  = ", NN
         print *, "Mat-Mat time[sec.] = ", t_w

         d_mflops = 2.0*dble(NN)*dble(NN)*dble(NN)/t_w
         d_mflops = d_mflops * 1.0e-6
         print *, "MFLOPS = ", d_mflops

       if (DEBUG .eq. 1) then
c      === Verification routine ----------------- 
         iflag = 0
         do j=1, NN
           do i=1, NN 
             if (dabs(C(i,j) - dble(NN)) > EPS) then
               print *, " Error! in (", i, ",", j, ") th argument."
               iflag = 1
               goto 10
             endif 
           enddo
         enddo
 10      continue
c        -----------------------------------------

           if (iflag .eq. 0) then
             print *, " OK!"
           endif

       endif
c      -----------------------------------------

       deallocate(A)
       deallocate(B)
       deallocate(C)


       stop
       end



       subroutine MyMatMat(C ,A, B, n)
       use omp_lib
       include 'mat-mat.inc'

       double precision C(NN, NN)
       double precision A(NN, NN)
       double precision B(NN, NN)
       integer n

       integer  i, j, k


!$omp parallel do private(j,k) 
       do i=1, n
         do j=1, n
           do k=1, n 
             C(i, j) = C(i, j) + A(i, k) * B(k, j) 
           enddo
         enddo
       enddo
!$omp end parallel do



      return
      end
