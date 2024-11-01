'''
imaster.academy/contenidos-tematicos/talentotech/TalentoTech/M2unidad2/Inteligencia%20artificial/Innovador/assets/files/M2-U2-L2-Ac1-Introduccion.pdf
'''
import numpy as np

# Definir una matriz de entrada (vector en escala de grises)
input_vector = np.array([2, 1, 0, 1, 2])  # Senal de entrada

# Definir un núcleo de convolución (Filtro o kernel) 
kernel = np.array([1, -1])  

# Aplicar la convolución unidimensional
#result = np.convolve(input_vector, kernel, mode='same')
result = np.convolve(input_vector, kernel, mode='valid')

# Imprimir resultados
print(result)
