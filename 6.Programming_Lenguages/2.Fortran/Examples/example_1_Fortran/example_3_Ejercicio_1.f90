!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_1

	implicit none
! Variables
	Integer A, B, suma, producto
! Cuerpo del program
	print*,"Entre dos numeros enteros"
	read*,A, B
	print*,"La suma de", A,"y", B,"es",suma
	print*,"El producto de", A,"y", B,"es",producto
	if (A > B) then
	  print*,A,"es mayor que",B
	else if (A < B) then
	  print*,A,"es menor que",B
	else 
	  print*,"Los numeros son iguales"
    endif
end program
