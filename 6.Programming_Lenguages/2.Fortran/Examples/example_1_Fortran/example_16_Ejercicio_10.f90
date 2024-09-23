!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_10

	implicit none
! Variables
	integer numero, suma, i, j

! Cuerpo del program
    print*,"Escriba un numero para hallar los numeros perfectos menores o igulaes que el"
    read*,numero

   
    do j = 1,numero
       suma = 0
       do i = 1, j/2
          if (mod(j, i) == 0) then
             suma = suma + i
	      endif
       enddo

       if (suma == j) then
         print*,numero,"es perfecto"
	  endif
   enddo

end program
