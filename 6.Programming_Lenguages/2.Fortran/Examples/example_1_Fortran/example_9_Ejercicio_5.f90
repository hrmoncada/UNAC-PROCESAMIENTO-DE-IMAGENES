!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_5

	implicit none
! Variables
	real base, potencia
    integer exponente, i

! Cuerpo del program
	print*,"Escriba la base y el exponnete de la potencia que quiere calcular"
	read*, base, exponente

    potencia = 1
    do i = 1,exponente 
       potencia = potencia * base
    enddo
   print*,"Resultado es",potencia

end program
