!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_2

	implicit none
! Variables
	Integer A, B, op
! Cuerpo del program
	print*,"Entre dos numeros enteros"
	read*,A, B
    print*,"Entre el tipo de operacion"
    print*,"1. Suma"
    print*,"2. Subtraccion"
    print*,"3. Multiplicacion"
    print*,"4. Division y Resto"
    read*,op

	if (op == 1) then
	  print*,"La suma es",A+B
	else if (op == 2) then
	  print*,"La subtraccion es",A-B
	else if (op == 3) then
	   print*,"La multiplicacion es",A*B
	else if (op == 4) then
       if (B == 0) then
          print*,"No se puede dividir por zero"
       else
	      print*,"La divicion es",A/B
          print*,"El residuo o resto",mod(A,B)
       end if
    else
        print*,"Numero de operacion no valido"
    end if

end program
