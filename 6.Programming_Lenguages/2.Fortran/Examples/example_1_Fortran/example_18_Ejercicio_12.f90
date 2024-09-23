!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_12

	implicit none
! Variables
	integer fecha1(3), fecha2(3)  !definamos dos vectores de enteros de longitud 3
    integer i

! Cuerpo del program
    print*,"Escriba la primera fecha (dd/mm/aaaa)"
    do i = 1, 3
       read*, fecha1(i)
    enddo

    print*,"Escriba la segunda fecha (dd/mm/aaaa)"
    do i = 1, 3
       read*, fecha2(i)
    enddo

    if (fecha1(3) > fecha2(3)) then  !miramos que ano es mayor
       print*,"La primera fecha es posterior a la segunda"
    else if (fecha1(3) < fecha2(3)) then !miramos si el otro ano es mayor
       print*,"La segunda fecha es posterior a la primera"
    else if (fecha1(2) > fecha2(2)) then  !miramos que mes es mayor
       print*,"La primera fecha es posterior a la segunda"
    else if (fecha1(2) < fecha2(2)) then  !miramos si el otro mes es mayor
       print*,"La segunda fecha es posterior a la primera"
    else if (fecha1(1) > fecha2(1)) then  !miramos que dia es mayor
       print*,"La primera fecha es posterior a la segunda"
    else if (fecha1(1) < fecha2(1)) then !miramos si el otro dia es mayor
       print*,"La segunda fecha es posterior a la primera"	
	else ! coinciden ano, mes, y dia
       print*,"Las fecha son iguales"
    endif

end program
