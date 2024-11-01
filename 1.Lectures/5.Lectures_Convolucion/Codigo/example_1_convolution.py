'''
https://gist.githubusercontent.com/jcespinosa/4759955/raw/8c1d61e17f2f0184a83c75f324011a37d0e283c2/convolution.py
'''

#!/usr/bin/python

# Librerias
from PIL import Image, ImageTk
from math import floor, sqrt
from random import random
import numpy

# ......
# ......
# otros filtros ya explicados
# ......
# ......


def convolution2D(f,h):                              # Convolucion discreta usando numpy
    fS, hS = f.shape, h.shape                        # Obtenemos el tamano de la mascara y la imagen
    F = numpy.zeros(shape=fS)                        # Creamos el arreglo donde se guardaran los calculos
    for x in range(fS[0]):                           # Recorremos la imagen a lo alto
        print str(round(float(x*100.0/fS[0]),2))     # Imprimimos el progreso de la rutina
        for y in range(fS[1]):                       # Recorremos la imagen a lo ancho
            mSum = numpy.array([0.0, 0.0, 0.0])      # Inicializamos la sumatoria en cero   
            for i in range(hS[0]):                   # Recorremos la mascara a lo alto
                i1 = i-(hS[0]/2)                     # Centramos la mascara a lo alto
                for j in range(hS[1]):               # Recorremos la mascara a lo ancho
                    j2 = j-(hS[0]/2)                 # Centramos la mascara a lo ancho  
                    try:                             # Realizamos la sumatoria de los valores
                        mSum += f[x+i1,y+j2]*h[i,j]  # Los bloques try, catch ayudan en a evitar errores
                    except IndexError: pass          # cuando estamos en los pixeles de las orillas
            F[x,y] = mSum                            # Agregamos el nuevo valor al arreglo de la gradiente
    return F      # Regresamos los valores de la gradiente calculados


def borderDetection(pixels, width): # Rutina para deteccion de bordes
    pixels = grayscale(pixels)      # Convertir la imagen a escala de grises
    pixels = slicing(pixels, width) # Pasar los pixeles a un arreglo compatible con numpy
    pixels = numpy.array(pixels)    # Pasar los pixeles a un arreglo numpy
 
    newPixels = list() # Lista que almacenara los nuevos pixeles de la nueva imagen
    iS = pixels.shape  # Obtenermos el tamano del arreglo (tamano de la imagen)

    n = 1.0/1.0        # Multiplicador de las mascaras
    # Usaremos 4 mascaras de Prewitt
    mask1 = numpy.array([[-1,0,1],[-1,0,1],[-1,0,1]]) * n # Prewitt simetrica vertical
    mask2 = numpy.array([[1,1,1],[0,0,0],[-1,-1,-1]]) * n # Prewitt simetrica horizontal
    mask3 = numpy.array([[-1,1,1],[-1,-2,1],[-1,1,1]])* n # Prewitt 0 grados
    mask4 = numpy.array([[1,1,1],[-1,-2,1],[-1,-1,1]])* n # Prewitt 45 grados

    g1 = convolution2D(pixels, mask1) # Llamamos a la rutina de convolucion discreta
    g2 = convolution2D(pixels, mask2) # para aplicar las mascaras
    g3 = convolution2D(pixels, mask3) # una por una
    g4 = convolution2D(pixels, mask4)

    for x in range(iS[0]):            # Recorremos los gradientes que hemos obtenido de aplicar
        for y in range(iS[1]):        # las mascaras a la imagen
            pixel = (g1[x,y]**2) + (g2[x,y]**2) + (g3[x,y]**2) + (g4[x,y]**2) # Buscamos los cambios de direcciones
            pixel = tuple([int(floor(sqrt(p))) for p in pixel])               # aplicando un acoplamiento
            newPixels.append(pixel)   # Agregamos el nuevo pixel a la lista para armar la nueva imagen
    
    newPixels = grayscale(newPixels)  # Binarizamos la imagen aplicando umbrales
    return newPixels                  # Regresamos la lista de nuevos pixeles
