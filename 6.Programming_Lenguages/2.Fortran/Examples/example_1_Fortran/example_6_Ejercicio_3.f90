!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_3

	implicit none
! Variables
	real menor, mediano, mayor, aux

! Cuerpo del program
	print*,"Escriba tres numeros enteros para ordenarlos de menor a mayor"
	read*,menor, mediano, mayor

	if (menor > mediano) then
      aux = mediano
      mediano = menor
      menor = aux
	endif

	if (menor > mayor) then
      aux = mayor
      mayor = menor
      menor = aux
	endif

	if (mediano > mayor ) then
      aux = mayor
      mayor = mediano
      mediano = aux
	endif

	print*,"Los numeros ordenados son : ",menor, mediano, mayor

end program
