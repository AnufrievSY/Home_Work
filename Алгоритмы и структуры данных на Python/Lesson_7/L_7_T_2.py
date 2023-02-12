"""
2. Отсортируйте по возрастанию методом слияния одномерный вещественный массив,
заданный случайными числами на промежутке [0; 50).
Выведите на экран исходный и отсортированный массивы.
"""

import random


def merge_sort(a):
    if len(a) == 1 or len(a) == 0:
        return a
    l_array = merge_sort(a[:len(a) // 2])
    r_array = merge_sort(a[len(a) // 2:])
    n = m = k = 0
    sort_a = [0] * (len(a))
    while n < len(l_array) and m < len(r_array):
        if l_array[n] <= r_array[m]:
            sort_a[k] = l_array[n]
            n += 1
        else:
            sort_a[k] = r_array[m]
            m += 1
        k += 1
    while n < len(l_array):
        sort_a[k] = l_array[n]
        n += 1
        k += 1
    while m < len(r_array):
        sort_a[k] = r_array[m]
        m += 1
        k += 1

    return sort_a


array = [i for i in range(0, 50)]
random.shuffle(array)

print('Изначальный список:\n', array)
print('Отсортирвоанный список:\n', merge_sort(array))
