'''
https://keepcoding.io/blog/que-es-la-convolucion-en-python/?srsltid=AfmBOopQFB-RW6Mo5fRpmE3C8DFwGb69oxZoFUF9217OoSESrCi4zL9p

https://numpy.org/doc/2.0/reference/generated/numpy.convolve.html

numpy.convolve(a, v, mode='full')[source]

1. Parameters :
a(N,) array_like, First one-dimensional input array.
v(M,) array_like, Second one-dimensional input array.

2. mode{‘full’, ‘valid’, ‘same’}, optional

‘full’: By default, mode is ‘full’. This returns the convolution at each point of overlap, with an output shape of (N+M-1,). At the end-points of the convolution, the signals do not overlap completely, and boundary effects may be seen.

‘same’: Mode ‘same’ returns output of length max(M, N). Boundary effects are still visible.

‘valid’: Mode ‘valid’ returns output of length max(M, N) - min(M, N) + 1. The convolution product is only given for points where the signals overlap completely. Values outside the signal boundary have no effect.

'''

veimport numpy as np

# Definir una matriz de entrada (vector en escala de grises)
input_vector = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9])

# Definir un núcleo de convolución
kernel = np.array([0, 1, -4, 1, 0])

# Aplicar la convolución unidimensional
result = np.convolve(input_vector, kernel, mode='same')

print(result)


result = np.convolve([1, 2, 3], [0, 1, 0.5])
print(result)

result = np.convolve([1,2,3],[0,1,0.5], 'same')
print(result)

result = np.convolve([1,2,3],[0,1,0.5], 'valid')
print(result)
