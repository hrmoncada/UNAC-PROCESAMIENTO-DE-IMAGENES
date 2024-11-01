'''
https://jvaldezch.wordpress.com/2020/10/14/interpolacion-usando-python/
'''

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import NearestNDInterpolator
df = pd.read_csv('input.csv')
plt.subplot(111)
plt.scatter(df['X'], df['Y'], s=3, marker='o', c=df['Z'], cmap=plt.cm.hsv)
plt.ylabel('Longitude')
plt.xlabel('Latitude')
cbar=plt.colorbar()
cbar.set_label('Chlor milligram m-3')plt.subplots_adjust(left=0.0, bottom=0.0, right=1.5, top=1.5, wspace=0.2, hspace=0.2)ax = plt.gca()
ax.set_facecolor('xkcd:black')
plt.show()

#Se realizan los arreglos necesarios para la interpolación:

miny, maxy = min(df['Y']), max(df['Y'])
minx, maxx = min(df['X']), max(df['X'])
grdi_x = np.linspace(minx, maxx, num=300, endpoint=False)
grdi_y = np.linspace(miny, maxy, num=300, endpoint=False)
yg, xg = np.meshgrid(grdi_y, grdi_x, indexing='ij')
x_g = xg.ravel()
y_g = yg.ravel()

#Para la primer prueba se va usar

df2 = df.drop(['Z'], 1)
df3 = df['Z']
points = np.array(df2)
values = np.array(df3)
interpolador = NearestNDInterpolator(points, values)
est_u = interpolador(x_g, y_g)

#Segunda interpolacion

from scipy.interpolate import griddata
grid_z0 = griddata(points, values, (x_g, y_g), method='linear')
plt.subplot(111)
plt.scatter(x_g, y_g, s=2, marker='o', c=grid_z0, cmap=plt.cm.hsv)
plt.ylabel('Latitude')
plt.xlabel('Longitude')
cbar=plt.colorbar()
cbar.set_label('Chlor milligram m-3')
plt.subplots_adjust(left=0.0, bottom=0.0, right=1.5, top=1.5, wspace=0.2, hspace=0.2)
ax = plt.gca()
ax.set_facecolor('xkcd:black')
plt.show()

#Nuestra ultima interpolación es

grid_z0 = griddata(points, values, (x_g, y_g), method='cubic')
plt.subplot(111)
plt.scatter(x_g, y_g, s=2, marker='o', c=grid_z0, cmap=plt.cm.hsv)
plt.ylabel('Latitude')
plt.xlabel('Longitude')
cbar=plt.colorbar()
cbar.set_label('Chlor milligram m-3')
plt.subplots_adjust(left=0.0, bottom=0.0, right=1.5, top=1.5, wspace=0.2, hspace=0.2)
ax = plt.gca()
ax.set_facecolor('xkcd:black')
plt.show()
