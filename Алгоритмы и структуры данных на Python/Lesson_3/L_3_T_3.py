"""
В массиве случайных целых чисел поменять местами минимальный и максимальный элементы.
"""

from random import randrange as rnd

num_list = [rnd(0, 10) for _ in range(10)]
print(f'Изначальный список: {num_list}')

n_min = num_list[0]
n_max = num_list[0]
for i in num_list:
    n_max = i if i > n_max else n_max
    n_min = i if i < n_min else n_min
pos_min = num_list.index(n_min)
pos_max = num_list.index(n_max)
print(f'Минимальное значение - {n_min}, стоит на позиции {pos_min}')
print(f'Максимальное значение - {n_max}, стоит на позиции {pos_max}')

del num_list[pos_min]
num_list.insert(pos_min, n_max)
del num_list[pos_max]
num_list.insert(pos_max, n_min)
print(f'Список после перестановки: {num_list}')
