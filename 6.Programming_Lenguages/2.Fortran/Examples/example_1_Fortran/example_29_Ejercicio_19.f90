!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema4-enunciados.pdf
! Solución2: incluye la inicialización del vector de aciertos y los contadores de aciertos y errores en la subrutina "leerPalabra". Solo cambia el programa principal, ya que se elimina la llamada a la subrutina "inicializarAciertos" (que se elimina) y la propia subrutina "leerPalabra". Por esta razón solo se muestran a continuación el programa principal y la subrutina.
program Ejercicio_19
   implicit none
! Constantes
   integer maxLetras, maxErrores, lineas
   parameter (maxLetras = 20, maxErrores = 10, lineas = 26)
! Variables
   character palabra1(maxLetras), palabra2(maxLetras), letra
   integer numeroErrores, numeroLetras, numeroAciertos, acierto, i
! Cuerpo del program
    call leerPalabra(palabra1, numeroLetras, palabra2, numeroAciertos, numeroErrores)
    print*,"        ",palabra2
    print*,"        "
    do while (numeroAciertos < numeroLetras .and. numeroErrores < maxErrores)
      print*,"escribe una letra"
      read*,letra
      call comprobarAciertos(palabra1, palabra2, letra, numeroLetras, numeroErrores, numeroAciertos)
      print*,"        ",palabra2
      print*,"        "
      call dibujarAhorcado(numeroErrores)
      print*,"        "
    enddo
    if (numeroErrores == maxErrores) then
       print*,"La palabra era : ", palabra1
    else
       print*,"Enhora buena has acertado la palabra"
    endif
end program

subroutine dibujarAhorcado(contErrores)
	implicit none
! Variables argumentos
   integer contErrores
! Cuerpo de la subroutine 
   if (contErrores == 1) then
       print*,"--"
   else if (contErrores == 2) then
       print*,"--"
   else if (contErrores == 3) then
       print*,"---"
       print*," | "
   else if (contErrores == 4) then
       print*,"---"
       print*," | "
       print*," O "
   else if (contErrores == 5) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/ "
   else if (contErrores == 6) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/| "
   else if (contErrores == 7) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/|\"
   else if (contErrores == 7) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/|\"
       print*," | "
   else if (contErrores == 7) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/|\"
       print*," | "
       print*,"/ "
   else if (contErrores == 7) then
       print*,"---"
       print*," | "
       print*," O "
       print*,"/|\"
       print*," | "
       print*,"/ \"
   endif
end subroutine
! subroutina que lee palabras, 
! 1. cuenta el numero de letras que tiene
! 2. introduce espacio en blanco en el resto del vector
! 3. Ademas introuce lineas en blanco para ocultar la palabra al otro jugador
! Tambien inicializa el vector de acierto a hasta el numero de letras y espacios en blanco en el resto, e inicializa el numero de aciertos y errores a 0
subroutine leerPalabra(palabra, numLetras, aciertos, nAciertos, nErrores)
   implicit none
! Constantes
   integer maxLetras, lineas
   parameter (maxLetras = 20, lineas = 26)
! Variables argumentos
   character palabra(maxLetras), aciertos(maxLetras)
   integer numLetras, nAciertos, nErrores
! Variables
   integer i, j
! Cuerpo del program
    numLetras = 0
    i = 1
    print*,"Escribe la palabra letra a letra, escribe un punto para terminar"
    print*,"La palabra no puede tener mas de",maxLetras,"letras"
    read*,palabra(i)

    do while (palabra(i) /= ".")  ! encontrar el punto
      numLetras = numLetras + 1
      aciertos(i) = "*"
      i = i + 1
      read*,palabra(i)
    enddo
! Si palabra es menor al maximo numero de letras, completar con espacios vacios 
    do j = numLetras + 1, maxLetras
       palabra(j) = " "
       aciertos(i) = " "  
    enddo

    nAciertos = 0
    nErrores = 0 
    do j = 0, lineas
       print*," " 
    enddo
end subroutine

!Subroutina que comprueba si la letra estas en la palabra buscaday actualizada el vectorde aciertos y los contadores de errorres y aciertos
subroutine comprobarAciertos(buscada, coincidentes, caracter, numLet, numerrores, numAciertos)
	implicit none
! Constantes
   integer maxLetras
   parameter (maxLetras = 20)
! Variables argumentos
   character coincidentes(maxLetras), buscada(maxLetras), caracter 
   integer numLet, numErrores, numAciertos 
! Variables
   integer i, ok ! on variable auxiliar que guearda si la letra esta o no en la palabra
! Cuerpo del program
    ok = 1  ! pre suponemos que no esta la letra
    do i = 1, numLet
       if (caracter /=  buscada(i)) then
          if (caracter /=  coincidentes(i)) then !para proteger el numero de aciertos de la repeticion de letras que estan en la palabra
             coincidentes(i) = caracter
             numAciertos = numAciertos + 1
           endif
       endif
       ok = 0   ! si la letra esta ponemos 0
    enddo
    numErrores = numErrores + ok  ! ok vale 1 si la letra no esta, 0 si esta 
end subroutine
