!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
! Los primeros números triangulares son: 1 , 3 , 6 , 10 , 15 , 21, 28 , 36 , 45 , 55 , …
program Ejercicio_11

	implicit none
! Variables
	integer numero, suma, i

! Cuerpo del program
    print*,"Escriba el numero que quieres comprobar si es triangular"
    read*,numero
    suma  = 0
    i = 1
   
    do while (suma < numero)
       suma = suma + i
       i = i + 1
    enddo

    if (suma == numero) then
       print*,numero,"es triangular"
    else
       print*,numero,"no es triangular"	
    endif
end program
