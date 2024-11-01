'''
imaster.academy/contenidos-tematicos/talentotech/TalentoTech/M2unidad2/Inteligencia%20artificial/Innovador/assets/files/M2-U2-L2-Ac1-Introduccion.pdf
'''

import numpy as np
from scipy.signal import convolve2d

# Definir una matriz de entrada (imagen en escala de grises)
input_matrix = np.array([[1, 2, 3, 3],
                         [4, 5, 6, 6],
                         [7, 8, 9, 9],
                         [7, 8, 9, 9]])

# Definir un núcleo de convolución (kernel)
kernel = np.array([[0, 1, 0],
                   [-1, 1, -1],
                   [0, 1, 0]])

# Aplicar la convolución 2D
#result = convolve2d(input_matrix, kernel, mode='same', boundary='symm')
result = convolve2d(input_matrix, kernel, mode='valid')
print(result)
