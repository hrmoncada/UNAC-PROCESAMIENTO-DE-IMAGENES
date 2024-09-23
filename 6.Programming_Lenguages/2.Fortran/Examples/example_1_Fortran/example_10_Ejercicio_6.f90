!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_6

	implicit none
! Variables
	real  factorial
    integer i, numero

! Cuerpo del program
	print*,"Escriba un numero para calcular su factorial"
	read*, numero

    factorial = 1

    do i = 2, numero 
       factorial = factorial * i
    enddo

    print*,"El factorial de ",numero,"es",factorial
end program
