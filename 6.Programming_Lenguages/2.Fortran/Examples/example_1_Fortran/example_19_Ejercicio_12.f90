!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_12

	implicit none
! Variables
	integer fecha1(3), fecha2(3)  !definamos dos vectores de enteros de longitud 3
    integer i, orden      ! definamos una variable auxiliar 
                          ! orden para guardar la posicion de la fecha mas reciente

! Cuerpo del program
    print*,"Escriba la primera fecha (dd/mm/aaaa)"
    do i = 1, 3
       read*, fecha1(i)
    enddo

    print*,"Escriba la segunda fecha (dd/mm/aaaa)"
    do i = 1, 3
       read*, fecha2(i)
    enddo
    
    orden = 0

    if (fecha1(3) > fecha2(3)) then  !miramos que ano es mayor
       orden = 1
    else if (fecha1(3) < fecha2(3)) then !miramos si el otro ano es mayor
       orden = 2
    else if (fecha1(2) > fecha2(2)) then  !miramos que mes es mayor
       orden = 1
    else if (fecha1(2) < fecha2(2)) then  !miramos si el otro mes es mayor
       orden = 2
    else if (fecha1(1) > fecha2(1)) then  !miramos que dia es mayor
       orden = 1
    else if (fecha1(1) < fecha2(1)) then !miramos si el otro dia es mayor
       orden = 2
    endif

    if (orden == 1) then  
       print*,"La primera fecha es posterior a la segunda"   
    else if (orden == 2) then 
      print*,"La segunda fecha es posterior a la primera"
	else ! coinciden ano, mes, y dia
       print*,"Las fecha son iguales"
    endif

end program
