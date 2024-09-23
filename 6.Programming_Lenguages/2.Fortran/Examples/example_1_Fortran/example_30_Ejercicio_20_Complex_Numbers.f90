PROGRAM NUMIMAG
! Calculadora elemental de complejos
  IMPLICIT NONE
! Declaración de variables
  REAL::F1(2), F2(2), SOLUCION(2)
  REAL::FE
  CHARACTER (1) OPCION
! Cuerpo del programa principal
  OPCION = '#'
  DO WHILE (OPCION /= 'S')
! Presentación menú
     PRINT *, "OPCIONES.............."
     PRINT *, "E : MULTIPLICACION POR ESCALAR"
     PRINT *, "C : CONJUGADO"
     PRINT *, "+ : SUMAR"
     PRINT *, "- : RESTAR"
     PRINT *, "X : MULTIPLICAR"
     PRINT *, "D : DIVIDIR"
     PRINT *, "O : OPUESTO"
     PRINT *, "I : INVERSO"
     PRINT *, "S : SALIR"
     PRINT *, "Escriba su opción: "
     READ *, OPCION

     SELECT CASE (OPCION)
         CASE ('E')
            PRINT *, "NUMERO IMAGINARIO"
            CALL LEER(F1)
            PRINT *, "NÚMERO ESCALAR"
            CALL LEERESC(FE)
            CALL ESCALAR(F1, FE)
            PRINT *, "EL RESULTADO DEL PRODUCTO ESCALAR ES:"
            CALL ESCRIBIR(F1)
         CASE ('+')
            PRINT *, "PRIMER NUMERO IMAGINARIO"
            CALL LEER(F1)
            PRINT *, "SEGUNDO NUMERO IMAGINARIO"
            CALL LEER(F2)
            CALL SUMA(F1, F2, SOLUCION)
            PRINT *, "EL RESULTADO DE LA SUMA ES:"
            CALL ESCRIBIR(SOLUCION)
        CASE ('-')
            PRINT *, "PRIMER NUMERO IMAGINARIO"
            CALL LEER(F1)
            PRINT *, "SEGUNDO NUMERO IMAGINARIO"
            CALL LEER(F2)
            CALL DIFERENCIA(F1, F2, SOLUCION)
            PRINT *, "EL RESULTADO DE LA RESTA ES:"
            CALL ESCRIBIR(SOLUCION)
       CASE ('X')
            PRINT *, "PRIMER NUMERO IMAGINARIO"
            CALL LEER(F1)
            PRINT *, "SEGUNDO NUMERO IMAGINARIO"
            CALL LEER(F2)
            CALL PRODUCTO(F1, F2, SOLUCION)
            PRINT *, "EL RESULTADO DE LA MULTIPLICACION ES:"
            CALL ESCRIBIR(SOLUCION)
       CASE ('D')
            PRINT *, "PRIMER NUMERO IMAGINARIO"
            CALL LEER(F1)
            PRINT *, "SEGUNDO NUMERO IMAGINARIO"
            CALL LEER(F2)
            CALL DIVISION(F1, F2, SOLUCION)
            PRINT *, "EL RESULTADO DE LA DIVISION ES:"
            CALL ESCRIBIR(SOLUCION)
       CASE ('O')
            PRINT *, "NUMERO IMAGINARIO"
            CALL LEER(F1)
            CALL OPUESTO(F1)
            PRINT *, "EL NÚMERO IMAGINARIO OPUESTO ES:"
            CALL ESCRIBIR(F1)
       CASE ('C')
            PRINT *, "NUMERO IMAGINARIO"
            CALL LEER(F1)
            CALL CONJUGADO(F1)
            PRINT *, "EL NÚMERO IMAGINARIO CONJUGADO ES:"
            CALL ESCRIBIR(F1)
       CASE ('I')
            PRINT *, "NUMERO IMAGINARIO"
            CALL LEER(F1)
            CALL INVERSO(F1)
            PRINT *, "EL NÚMERO IMAGINARIO INVERSO ES:"
            CALL ESCRIBIR(F1)
        END SELECT
  END DO
  PRINT *, "FIN DEL PROGRAMA..........."
END PROGRAM NUMIMAG

! Subprogramas
SUBROUTINE LEER(A)
! Introduce en A un complejo desde teclado
  IMPLICIT NONE
  REAL A(2)
  PRINT *, "Introduzca parte real y parte imaginaria"
  READ *, A(1), A(2)
END SUBROUTINE

SUBROUTINE LEERESC(A)
! Introduce en A un escalar desde teclado
  IMPLICIT NONE
  REAL A
  PRINT *, "Introduzca el número escalar"
  READ *, A
END SUBROUTINE

SUBROUTINE ESCRIBIR(A)
! Imprime el complejo A
  IMPLICIT NONE
  REAL A(2)
  IF (A(1) /= 0) THEN
     PRINT *, A(1)
  END IF
  IF (A(2) /= 0) THEN
    PRINT *, A(2), 'i'
  END IF
END SUBROUTINE

SUBROUTINE ESCALAR(A,K)
! Multiplica el complejo A por el escalar K
  IMPLICIT NONE
  REAL A(2)
  REAL K
  A(1) = A(1) * K
  A(2) = A(2) * K
END SUBROUTINE

SUBROUTINE CONJUGADO(A)
! Cambia de signo la parte imaginaria de A
  IMPLICIT NONE
  REAL A(2)
  A(2) = -A(2)
END SUBROUTINE

SUBROUTINE SUMA(A,B,C)
! Suma los complejos A y B y guarda el resultado en C
  IMPLICIT NONE
  REAL A(2), B(2), C(2)
  C(1) = A(1) + B(1)
  C(2) = A(2) + B(2)
END SUBROUTINE

SUBROUTINE DIFERENCIA(A,B,C)
! Resta los complejos A y B y guarda el resultado en C
  IMPLICIT NONE
  REAL A(2), B(2), C(2)
  CALL OPUESTO(B)
  CALL SUMA (A, B,C)
END SUBROUTINE

SUBROUTINE PRODUCTO(A,B,C)
! Multiplica los complejos A y B y guarda el resultado en C
  IMPLICIT NONE
  REAL A(2), B(2), C(2)
  C(1) = (A(1) * B(1)) - (A(2) * B(2))
  C(2) = (A(1) * B(2)) + (A(2) * B(1))
END SUBROUTINE

SUBROUTINE DIVISION(A,B,C)
! Divide los complejos A y B y guarda el resultado en C
  IMPLICIT NONE
  REAL A(2), B(2), C(2)
  CALL CONJUGADO(B)
  CALL PRODUCTO (A,B,C)
  CALL ESCALAR (C, 1/((B(1)*B(1)) + (B(2)*B(2))))
END SUBROUTINE

SUBROUTINE OPUESTO(A)
! Cambia el signo tanto de la parte real como de la imaginaria de A
  IMPLICIT NONE
  REAL A(2)
  A(1) = -A(1)
  A(2) = -A(2)
END SUBROUTINE

SUBROUTINE INVERSO(A)
! Inviete el complejo A
  IMPLICIT NONE
  REAL A(2),AUX(2)
  AUX(1) = 1
  AUX(2) = 0
  CALL DIVISION(AUX,A,A)
END SUBROUTINE
