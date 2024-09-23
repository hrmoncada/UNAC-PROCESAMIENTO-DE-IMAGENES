!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema4-enunciados.pdf
program Ejercicio_16
	implicit none

! Variables
   integer numero1, numero2, factorial ! decalremos la variable factorial para poder utilizar la funcion

! Cuerpo del program
    print*,"Entre dos numeros naturales para calcular su combinacion" 
    print*,"El primer numero tiene que se mayor que el segundo numero"
    read*, numero1, numero2

    if (numero2 > 0 .and. numero1 > numero2) then
       print*,"El numero combinatorio de",numero1,"y",numero2,"es:"
! llamamos a la funciion usando distintos argumentos
       print*, factorial(numero1)/(factorial(numero2)*factorial(numero1-numero2))
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
       factorial = factorial*i ! asignamos el nombre dde la function and valor que devolvera
   enddo

end function
