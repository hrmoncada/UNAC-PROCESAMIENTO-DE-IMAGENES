!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_13

	implicit none
!Constantes
	integer numDias  !definamos el tipo de la constante damos el valor a la constante
    parameter  (numDias = 30)   

! Variables
   integer temp(numDias) ! definimos un vector de temperaturas cuyas longitud depende de numDias
   integer i, maxima, minima, media

! Cuerpo del program
    do i = 1, numDias
       print*,"Introduce la temperatura", i
       read*, temp(i)
    enddo

    maxima = temp(1) ! inicializamos maxima a la primera temperatura del vector
    minima = temp(1) ! inicializamos minima a la primera temperatura del vector
    media = temp(1)  ! inicializamos media a 0 tenemos que empezar el bucle en 1

    do i = 1, numDias
       if (temp(i) > maxima) then  
          maxima =  temp(i)
      else if (temp(i) < minima) then  
         minima =  temp(i)
      endif

      media = media + temp(i)
    enddo

    print*,"La temperatura maxima fue:",maxima
    print*,"La temperatura minima fue:",minima
    print*,"La temperatura media fue:",media/numDias

end program
