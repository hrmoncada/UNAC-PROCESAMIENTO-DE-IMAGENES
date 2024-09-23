!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema4-enunciados.pdf
program Ejercicio_18
	implicit none

! Variables
   integer A(2), B(2), C(2)
   character(1) operacion

! Cuerpo del program
    call lessFraccion(A)
    call lessFraccion(B)
    call menu(operacion)

    if (operacion == '+') then
        call suma(A, B, C)
    else  if (operacion == '+') then
        call resta(A, B, C)
    else  if (operacion == '*') then
        call multiplicacion(A, B, C)
    else  if (operacion == ':') then
        call division(A, B, C)
    else 
       print*,"Operacio no valida"
    endif
    call escribirFraccion(C)
end program

! subroutine que lee una fraccion introducida por teclado, previa peticion
subroutine lessFraccion(F)
	implicit none
! Variables argumentos
   integer F(2)
! Cuerpo de la subroutine 
    print*, "Entre el numerador y denominador de la fraccion "
    read*, F(1), F(2)
    do while (F(2) == 0)
       print*,"El denominador ha de ser distinto de zero"
       print*,"Enter de nuevo el denominador"
       read*, F(2)
   enddo
end subroutine

! subroutine que calcula el maximo comun divisor
subroutine menu(op)
	implicit none
! Variables argumentos
   character(1) op
! Cuerpo de la subroutine 
    print*, "+ suma"
    print*, "- resta"
    print*, "* multiplcacion"
    print*, ": division"
    read*, op
end subroutine

! subroutine que calcula la suma de dos fracciones a/b + c/d = (a*d + c*b)/(b * d)
subroutine suma(F1, F2, F3)
   implicit none
! Variables argumentos
   integer F1(2), F2(2), F3(2)
! Cuerpo de la subroutine 
   F3(1) = F1(1)*F2(2) + F1(2)*F2(1) 
   F3(2) = F1(2)*F2(2)
end subroutine

! subroutine que calcula la resta de dos fracciones a/b - c/d = (a*d - c*b)/(b * d)
subroutine resta(F1, F2, F3)
	implicit none
! Variables argumentos
   integer F1(2),F2(2),F3(2)
! Cuerpo de la subroutine 
   F3(1) = F1(1)*F2(2) - F1(2)*F2(1) 
   F3(2) = F1(2)*F2(2)
end subroutine

! subroutine que calcula la multiplicacion de dos fracciones a/b * c/d = (a * c)/(b * d)
subroutine multiplicacion(F1, F2, F3)
	implicit none
! Variables argumentos
   integer F1(2), F2(2), F3(2)
! Cuerpo de la subroutine 
   F3(1) = F1(1)*F2(1)
   F3(2) = F1(2)*F2(2)
end subroutine

! subroutine que calcula la divicion de dos fracciones a/b : c/d = (a * d)/(b * c)
subroutine division(F1, F2, F3)
	implicit none
! Variables argumentos
   integer F1(2), F2(2), F3(2)
! Cuerpo de la subroutine 
   F3(1) = F1(1)*F2(2)
   F3(2) = F1(2)*F2(1)
end subroutine

! subroutine esribir una fraccion
subroutine escribirFraccion(F)
	implicit none
! Variables argumentos
   integer F(2)
! Variables
   integer mcd, aux

! Cuerpo de la subroutine
   aux  = mcd(F(1), F(2))
 
   if (aux /= 0) then
     F(1) = F(1)/aux
     F(2) = F(2)/aux
  endif
  print*,"Resultado es :", F(1), "/", F(2)

end subroutine

! function que calcula maximo comun divisor de dos numeros enteros
integer function mcd(num1, num2)
	implicit none
! Variables argumentos
   integer num1, num2
! Variables
   integer i, aux1, aux2

! Cuerpo de la subroutine
   aux1 = num1
   aux2 = num2
 
   do while (aux1 /= 0 .and. aux2 /= 0) 
      if (aux1 > aux2) then
        aux1  = mod(aux1, aux2)
      else
        aux2  = mod(aux1, aux2)
      endif
      mcd = abs(aux1 + aux2) !devolvemos el valor absoluto ya que podemos tener valores negativos
   enddo
end function

