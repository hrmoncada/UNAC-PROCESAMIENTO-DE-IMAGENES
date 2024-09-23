!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
!https://www.vaxasoftware.com/doc_edu/mat/numperfe_esp.pdf
!Los números perfectos son generados por la formula 2^(p-1) (2^p - 1), donde p y 2^p - 1 son primos
!Pos. p Número perfecto   Nº dígitos  Año Descubridor
!1    2     6                 1 
!2    3     28                2 
!3    5     496               3 
!4    7     8128              4 
!5    13    33550336          8       1456 anónimo
!6    17    8589869056        10      1588 Cataldi
!7    19    137438691328      12      1588 Cataldi

program Ejercicio_9

	implicit none
! Variables
	integer numero, suma, i

! Cuerpo del program
    print*,"Escriba el numero que quieres comparar"
    read*,numero
    suma = 0
    i = 1
    do while ((suma < numero) .or. (i < numero/2))
       if (mod(numero, i) == 0) then
         suma = suma + i
	   endif
       i = i + 1
    enddo

    if (suma == numero) then
         print*,numero,"es perfecto"
	  else 
         print*,numero,"no es perfecto"
	  endif

end program
