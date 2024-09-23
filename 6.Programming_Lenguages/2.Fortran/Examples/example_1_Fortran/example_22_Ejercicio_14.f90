!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_14

	implicit none
!Constantes
	integer numDias  !definamos el tipode la constante damos el valor a la constante
    parameter  (numDias = 5)   
    !parameter numDias = 5 !algunos compiladores admiten la ddefunicion de constante asi

! Variables
   integer temp(numDias) ! definimos un vector de temperaturas cuyas longitud depende de numDias
   integer i, temperatura, const

! Cuerpo del program
    do i = 1, numDias
       print*,"Introduce la temperatura", i
       read*, temp(i)
    enddo

   print*,"Introduce la temperatura que quieres comprobar"
   read*,  temperatura
   
   const  = 0

    do i = 1, numDias
       if (temp(i) == temperatura) then
          print*,"La temperatura",temperatura,"si se dio en el mes", const, "veces"
          const =  const + 1
       endif
    enddo

   if (const /= 0) then  
      print*,"Tubimos",temperatura,"grados en el mes, ocurrio", const, "dia/dias"
   else 
      print*,"La temperatura",temperatura,"no se dio en el mes"
   endif

end program
