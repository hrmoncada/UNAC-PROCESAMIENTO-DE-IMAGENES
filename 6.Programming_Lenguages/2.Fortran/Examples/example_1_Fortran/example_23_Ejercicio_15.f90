!https://ocw.uc3m.es/pluginfile.php/3635/mod_page/content/13/tema3-enunciados.pdf
program Ejercicio_15

	implicit none
!Constantes 
    integer nCurso, nAsignatura
    parameter (nCurso = 4)      !constante numero de cursos
    parameter (nAsignatura = 5)  !constante numero de asignaturas
! Variables
   real notas(nCurso, nAsignatura) ! matrix notas
   real media
   real mediaCurso(nCurso)         ! vector de medias de los cursos
   real mediaAsignatura(nAsignatura)     ! vector de medias de las asignaturas
   integer i, j

! Cuerpo del program
    do i = 1, nCurso                   ! recorremos la matrix de filas
       do j = 1, nAsignatura           ! recorremos la matrix de columnas
          print*,"Introduce la nota de la asignatura", j,"en el curso",i
          read*, notas(i, j)
       enddo
   enddo
! Calculamos la media global de alunmos
    media = 0                           ! inicializamos la media a 0
    do i = 1, nCurso                   ! recorremos la matrix de filas
       mediaCurso(i) = 0               ! inicializamos el vector a 0
       do j = 1, nAsignatura           ! recorremos la matrix de columnas
          media =  media + notas(i, j) ! Calculmos la suma  de todas las notas
       enddo
   enddo

   media =  media/(nCurso * nAsignatura) ! Calculmos la media

! Calculamos la media de cada curso
    do i = 1, nCurso                            ! recorremos la matrix de filas
       mediaCurso(i) = 0                        ! inicializamos el vector a 0
       do j = 1, nAsignatura                    ! recorremos la matrix de columnas
          mediaCurso(i) = mediaCurso(i)  + notas(i, j)
       enddo
       mediaCurso(i) =  mediaCurso(i) / nAsignatura  ! Calculmos la media del curso i
   enddo

! Calculamos la media de cada curso
    do j = 1, nAsignatura     ! recorremos la matrix de columnas
       mediaAsignatura(j) = 0 ! inicializamos el vector a 0
       do i = 1, nCurso      ! recorremos la matrix de filas
          mediaAsignatura(i) = mediaAsignatura(i)  + notas(i, j) ! Calculmos la suma  de notas de la  asignatura j
       enddo
       mediaAsignatura(i) =  mediaAsignatura(i) / nCurso  ! Calculmos la media del asignatura j
    enddo

! Imprimimos las medias
    print*,"The nota media global de alumnos es", media
    do i = 1, nCurso      
       print*,"The nota media del curso",i,"es",mediaCurso(i)
    enddo
    do j = 1, nAsignatura   
       print*,"The nota media del asignatura", j,"es",mediaAsignatura(j) 
    enddo

end program
