!https://web.pa.msu.edu/people/duxbury/courses/phy201_f06/ModuleExample.f90
!  this module can be placed in separate file and compiled separately 
module vectorfun
  implicit none
contains
  function length(v)
! compute the euclidian length of a vector
    real    :: length, v(:), s
    integer :: n, i
    n = size(v)
    s = 0.
    do i=1,n
      s = s + v(i)**2
    end do
    length=sqrt(s)
  end function
end module

! the main program can be placed in a separate file and compiled separately
program test
  use vectorfun ! this makes all declarations and definitions of module available
  implicit none
  integer :: i,n
  real    :: r 
  real, allocatable :: x(:)
  print *,'n ='
  read *, n
  allocate(x(n))
  do i=1,n
    print *,'x(',i,') ='
    read *, x(i)
  end do
  r=length(x)
  print *, 'length =',r
end program
