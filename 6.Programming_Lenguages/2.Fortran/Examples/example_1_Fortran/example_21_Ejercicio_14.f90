!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_14

	implicit none
!Constantes
	integer numDias  !definamos el tipode la constante damos el valor a la constante
    parameter  (numDias = 5) 
    !parameter numDias = 5 !algunos compiladores admiten la defunicion de constante asi

! Variables
   integer temp(numDias) ! definimos un vector de temperaturas cuyas longitud depende de numDias
   integer i, temperatura

! Cuerpo del program
    do i = 1, numDias
       print*,"Introduce la temperatura", i
       read*, temp(i)
    enddo

   print*,"Introduce la temperatura que quieres comprobar"
   read*, temperatura
   
   i  = 1

   do while ((temp(i) /= temperatura) .and. (i < numDias)) 
      i = i + 1
   enddo 

   if (temp(i) == temperatura) then  
      print*,"La temperatura",temperatura,"si se dio en el mes"
   else 
      print*,"La temperatura",temperatura,"no se dio en el mes"
   endif

end program
