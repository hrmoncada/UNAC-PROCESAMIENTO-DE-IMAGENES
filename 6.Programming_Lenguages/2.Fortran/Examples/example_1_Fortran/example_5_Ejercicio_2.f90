!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_2

	implicit none
! Variables
	Integer A, B
    Character op

! Cuerpo del program
	print*,"Entre dos numeros enteros"
	read*,A, B
    print*,"Entre el tipo de operacion"
    print*,"+. Suma"
    print*,"-. Subtraccion"
    print*,"*. Multiplicacion"
    print*,":. Division y Resto"
    read*,op

	if (op == "+") then
	  print*,"La suma es",A+B
	else if (op == "-") then
	  print*,"La subtraccion es",A-B
	else if (op == "*") then
	   print*,"La multiplicacion es",A*B
	else if (op == ":") then
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
