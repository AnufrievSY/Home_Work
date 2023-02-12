"""
В одномерном массиве целых чисел определить два наименьших элемента.
Они могут быть как равны между собой (оба минимальны), так и различаться.
"""

from random import randrange as rnd

num_list = [rnd(0, 10) for _ in range(10)]
print(f'Изначальный список: {num_list}')

n_min = num_list[0]
for i in num_list:
    n_min = i if i < n_min else n_min
pos_min = num_list.index(n_min)
print(f'1. Минимальное значение - {n_min}, стоит на позиции {pos_min}')

num_list = num_list[pos_min+1:]
n_min = num_list[0]
for i in num_list:
    n_min = i if i < n_min else n_min
pos_min = num_list.index(n_min)+pos_min+1
print(f'2. Минимальное значение - {n_min}, стоит на позиции {pos_min}')

