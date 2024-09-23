!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_9

	implicit none
! Variables
	integer numero, suma, i

! Cuerpo del program
    print*,"Escriba el numero que quieres comparar"
    read*,numero
    suma = 0

    print*,numero/2

    do i = 1, numero/2
       if (mod(numero, i) == 0) then
         suma = suma + i
         print*, i, mod(numero, i), suma
	   endif
    enddo

    if (suma == numero) then
       print*,numero,"es perfecto"
	else 
       print*,numero,"no es perfecto"
	endif

end program
