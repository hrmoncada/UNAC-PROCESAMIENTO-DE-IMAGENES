! https://stackoverflow.com/questions/23702118/not-declaring-a-loop-counter-up-front-in-fortran
PROGRAM Foo

  IMPLICIT NONE

  CALL Bar(0.0,-1)

END PROGRAM Foo

SUBROUTINE Bar(t,i)

  DIMENSION(5) :: R = 0.5
  REAL :: s = 0.5

  DO k = 1, 5
     R(k) = k * i
  END DO
  CALL Random(s) ! Random is a well-behaved pseudorandom number generator
                 ! on the interval ]0,1[ implemented elsewhere.
  k = 1 + (s * 5)
  t = R(k)
END SUBROUTINE Bar
