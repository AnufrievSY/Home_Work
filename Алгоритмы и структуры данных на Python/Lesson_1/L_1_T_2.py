"""
По введенным пользователем координатам двух точек вывести уравнение прямой вида y = kx + b, проходящей через эти точки.
"""
from matplotlib import pyplot as plt
import numpy as np

x_1 = int(input('Введите значение X первой точки: '))
y_1 = int(input('Введите значение Y первой точки: '))
x_2 = int(input('Введите значение X второй точки: '))
y_2 = int(input('Введите значение Y второй точки: '))

k = (y_2-y_1)/(x_2-x_1)
b = y_1 - k * x_1

x = np.linspace(-10, 10, 100)
y = k*x+b

plt.plot(x, y)
plt.show()
