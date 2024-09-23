!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema4-enunciados.pdf
program Ejercicio_17
	implicit none

! Variables
   integer numero1, numero2, mcd, mcm ! decalremos la variable factorial, ombinatorio para poder utilizar la funciones

! Cuerpo del program
    print*,"Entre dos numeros naturales para calcular su maximo comun divisor y su minimo comun multiplo" 
    print*,"El primer numero tiene que se mayor que el segundo numero"
    read*, numero1, numero2
! llamamos a la funciion usando distintos argumentos
    if (numero2 >= 0 .and. numero2 >= 0) then
       print*,"El maximo comun divisor de",numero1,"y",numero2,"es:",mcd(numero1, numero2)
       print*,"El minimo comun multiplo e",numero1,"y",numero2,"es:",mcm(numero1, numero2)
    else
      print*,"Los numeros tiene que ser naturales"
    endif
end program

! Funcion que calcula el maximo comun divisor
integer function mcd(num1, num2)
	implicit none
! Variables argumentos
   integer num1, num2
! Variables
   integer i, aux1, aux2
! Cuerpo de la funcion
     aux1 = num1
     aux2 = num2
    
    do while (aux1 /= 0 .and. aux2 /= 0)
       if (aux1 > aux2) then
          aux1 =  mod(aux1, aux2)
       else
          aux2 =  mod(aux2, aux1)
       endif
       mcd = aux1 + aux2
   enddo
end function

! Funcion que calcula el minimo comun multiplo
integer function mcm(num1, num2)
	implicit none
! Variables argumentos
   integer num1, num2
! Variables
   integer i, aux, mcd
! Cuerpo de la funcion
     aux = mcd(num1, num2)
    
    if (aux > 0) then
       mcm = num1 * num2/aux
   else
       mcm = 0
   endif
end function
