'''
Running Python with OpenMP parallelization
https://raw.githubusercontent.com/AaltoSciComp/hpc-examples/master/python/python_openmp/python_openmp.py
Triton Examples
https://github.com/AaltoSciComp/hpc-examples.git
'''

#!/usr/bin/env python
import os
from time import time
import numpy as np

print('Using %d processors' % int(os.getenv('SLURM_CPUS_PER_TASK',1)))
print('Using %d threads' % int(os.getenv('OMP_NUM_THREADS', 1)))
print('Using %d tasks' % int(os.getenv('SLURM_NTASKS', 1)))

nrounds = 5

t_start = time()

for i in range(nrounds):
    a = np.random.random([2000,2000])
    a = a + a.T
    b = np.linalg.pinv(a)

t_delta = time() - t_start

print('Seconds taken to invert %d symmetric 2000x2000 matrices: %f' % (nrounds, t_delta))
