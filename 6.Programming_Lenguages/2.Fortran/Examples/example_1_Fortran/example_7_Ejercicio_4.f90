!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema2-enunciados.pdf
program Ejercicio_4

	implicit none
! Variables
	real angulo1, angulo2, angulo3

! Cuerpo del program
	print*,"Escriba tres angulos"
	read*,angulo1, angulo2, angulo3

	if (angulo1 + angulo2 + angulo3 /= 180 .or. angulo1 <= 0 .or. angulo2 <= 0 .or. angulo3 <= 0) then
         print*,"Los angulos no forman triangulo"
	else if (angulo1 == 90 .or. angulo2 == 90 .or. angulo3 == 90) then
         print*,"Los angulos forman un triangulo rectangulo "
	else if (angulo1 > 90 .or. angulo2 > 90 .or. angulo3 > 90) then
         print*,"Los angulos forman un triangulo obtusangulo"
	else 
         print*,"Los angulos forman un triangulo acutangulo"
	endif

end program
