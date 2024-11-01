'''
https://docs.scipy.org/doc/scipy/reference/generated/scipy.datasets.ascent.html

pip install pooch
'''

import scipy.datasets
import matplotlib.pyplot as plt

ascent = scipy.datasets.ascent()
print(ascent.shape)
print(ascent.max())

plt.gray()
plt.imshow(ascent)
plt.show()
