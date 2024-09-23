!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema4-enunciados.pdf
program Ejercicio_16
	implicit none

! Variables
   integer numero1, numero2, combinatorio ! decalremos la variable factorial, ombinatorio para poder utilizar la funciones

! Cuerpo del program
    print*,"Entre dos numeros naturales para calcular su combinacion" 
    print*,"El primer numero tiene que se mayor que el segundo numero"
    read*, numero1, numero2

    if (numero2 >= 0 .and. numero1 >= numero2) then
       print*,"El numero combinatorio de",numero1,"y",numero2,"es:"
! llamamos a la funciion usando distintos argumentos
       print*,combinatorio(numero1, numero2)
    else
       print*,"El primer numero a de ser mayor o igual que el segundo numero"
    endif

end program

! Funcion que calcula el factorial de un numero
integer function factorial(numero)
   implicit none

! Variables argumentos
   integer numero
! Variables
   integer i

! Cuerpo de la funcion
    factorial = 1      

    do i = 1, numero
       factorial = factorial * i ! asignamos el nombre dde la function and valor que devolvera
   enddo

end function

! Funcion que calcula el numero combinatorio de dos numeros, el primer numero a de ser mayor o igual que el segundo numero
integer function combinatorio(n, m)
!  implicit none

! Variables argumentos
   integer n, m
! Variables
   integer i, factorial

! Cuerpo de la funcion  combinatorio
   combinatorio  = factorial(n)/(factorial(m) * factorial(n - m)) 

end function
! asignamos el nombre de la function and valor que devolvera




