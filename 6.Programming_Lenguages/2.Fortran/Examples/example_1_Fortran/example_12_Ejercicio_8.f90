!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_8

	implicit none
! Variables
	integer posicion, numero, anterior,aux, i

! Cuerpo del program
    print*,"Introduce la posicion del numero de la succesion de Fibonacci que desea calcular"
    read*,posicion
    anterior = 0
    numero = 1

    do i = 1, posicion
      aux  = numero
      numero = numero + anterior
      anterior = aux
    enddo

   print*,"El numero de Fibonacci es", numero

end program
