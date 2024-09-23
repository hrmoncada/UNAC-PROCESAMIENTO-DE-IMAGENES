!hhttps://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-ejemplo.pdf
program multiplicacion_Rusa

	implicit none
! Varioables
	Integer A,B,suma, auxA, auxB, loop
	logical signo

! Cuerpo del program
	print*, " El algoritmo de multiplicación rusa consiste en:"
	!print '(/)'

	print*, "1. Escribir los números (A y B) que se desea multiplicar en la parte superior"
	print *, "de dos columnas."
	print '(/)'

	print*, "2. Dividir A entre 2, sucesivamente, ignorando el resto, hasta llegar a la"
	print*, "unidad. escribir los resultados en la columna A."
	print '(/)'

	print*, "3. Multiplicar B por 2 tantas veces como veces se ha dividido A entre 2."
	print*, "escribir los resultados sucesivos en la columna B."
	print '(/)'

	print*, "4. Sumar todos los números de la columna B que estén al lado de un número"
	print*, "impar de la columna A. Éste es el resultado."
	print '(/)'
    loop = 1
    do while (loop == 1)
	print*, "Escribe dos números que quieras mutiplicar (e.g.  27 × 82):"
	!print '(/)'
	Read*, A,B

	signo = ((A < 0 .ANd. B < 0) .OR. (A > 0 .ANd. B > 0))
	auxA = abs(A)
	auxB = abs(B)
	suma = 0

	print '(/)'
	print '(A15, A15, A15)', "   A  |", " B  |", "Suma"
	do while (auxA >= 1)
	   If (mod(auxA,2) /= 0) Then
		  suma = suma + auxB
		  print*, auxA, " | " , auxB ," | " , suma
	   else
		  print*, auxA, " | " , auxB ," | "
	   end if
	   auxA = auxA/2
	   auxB = auxB*2
	end do

	print '(/)'
	If (signo) Then
	   print*, A,' x', B, ' = ', suma
	else
	   print*, A,' x', B, '=', -suma
	end If
    print*,"Presione:"
    print*,"        1 Si desea continuar"
    print*,"        0 si desea terminar"
	Read*,loop
    enddo

end program
