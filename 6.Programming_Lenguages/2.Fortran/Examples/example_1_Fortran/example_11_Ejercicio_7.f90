!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_7

	implicit none
! Variables
	real numero1, numero2

! Cuerpo del program
	print*,"Escriba dos numeros naturales"
	read*,numero1, numero2

    do while (numero1 /= 0 .and. numero2 /= 0)
       if (numero1 >  numero2) then
         numero1 = mod(numero1,  numero2)
	  else 
         numero2 = mod(numero2,  numero1)
	  endif
    enddo

	if (numero1 == 0) then
         print*,"El maximo comun divisor es", numero2
	else 
         print*,"El maximo comun divisor es", numero1
	endif

!tambien se puede hacer sin el if final si sumamos lod dos numeros
!print*,"El maximo comun divisor es", numero1+numero2
end program
