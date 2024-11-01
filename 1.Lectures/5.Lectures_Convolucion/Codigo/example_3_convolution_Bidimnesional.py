'''
https://keepcoding.io/blog/que-es-la-convolucion-en-python/?srsltid=AfmBOopQFB-RW6Mo5fRpmE3C8DFwGb69oxZoFUF9217OoSESrCi4zL9p

https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.convolve2d.html
convolve2d(in1, in2, mode='full', boundary='fill', fillvalue=0)

1.Parameters:
in1 : array_like, First input.
in2 : array_like, Second input. Should have the same number of dimensions as in1.

2. modestr {‘full’, ‘valid’, ‘same’}, optional
A string indicating the size of the output:

full : The output is the full discrete linear convolution of the inputs. (Default)
valid : The output consists only of those elements that do not rely on the zero-padding. In ‘valid’ mode, either in1 or in2 must be at least as large as the other in every dimension.
same : The output is the same size as in1, centered with respect to the ‘full’ output.

3. boundarystr {‘fill’, ‘wrap’, ‘symm’}, optional
A flag indicating how to handle boundaries:

fill : pad input arrays with fillvalue. (default)
wrap : circular boundary conditions.
symm : symmetrical boundary conditions.
fillvalue : scalar, optional; Value to fill pad input arrays with. Default is 0.

Returns:
out : ndarray; A 2-dimensional array containing a subset of the discrete linear convolution of in1 with in2.
'''

import numpy as np
from scipy.signal import convolve2d

# Definir una matriz de entrada (imagen en escala de grises)
input_matrix = np.array([[1, 2, 3],
                         [4, 5, 6],
                         [7, 8, 9]])

# Definir un núcleo de convolución
kernel = np.array([[0, 1, 0],
                   [1, -4, 1],
                   [0, 1, 0]])

# Aplicar la convolución 2D
result = convolve2d(input_matrix, kernel, mode='same', boundary='symm')

print(result)
