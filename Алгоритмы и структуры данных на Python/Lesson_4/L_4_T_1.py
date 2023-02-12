"""
Проанализировать скорость и сложность одного любого алгоритма из разработанных в рамках домашнего
задания первых трех уроков.
Примечание. Идеальным решением будет:
a. выбрать хорошую задачу, которую имеет смысл оценивать,
b. написать 3 варианта кода (один у вас уже есть),
c. проанализировать 3 варианта и выбрать оптимальный,
d. результаты анализа вставить в виде комментариев в файл с кодом (не забудьте указать, для
каких N вы проводили замеры),
e. написать общий вывод: какой из трёх вариантов лучше и почему.
"""
import functools
from random import randint as rnd
import cProfile
import timeit


def version_1():
    a = rnd(-10, 10)
    b = rnd(-10, 10)
    c = rnd(-10, 10)
    if a > b:
        if b > c:
            return f'Среднее число: {b}'
        else:
            if a > c:
                return f'Среднее число: {c}'
            else:
                return f'Среднее число: {a}'
    else:
        if c > b:
            return f'Среднее число: {b}'
        else:
            if a > c:
                return f'Среднее число: {a}'
            else:
                return f'Среднее число: {c}'


def version_2():
    a = rnd(-10, 10)
    b = rnd(-10, 10)
    c = rnd(-10, 10)

    if a > b > c or a < b < c:
        return f'Среднее число: {b}'
    elif b > c > a or b < c < a:
        return f'Среднее число: {c}'
    elif c > a > b or c < a < b:
        return f'Среднее число: {a}'


def version_3():
    from statistics import median
    a = rnd(-10, 10)
    b = rnd(-10, 10)
    c = rnd(-10, 10)
    return median([a, b, c])


def version_4():
    a = rnd(-10, 10)
    b = rnd(-10, 10)
    c = rnd(-10, 10)
    lst = [a, b, c]
    lst.sort()
    return lst[1]


@functools.lru_cache()
def version_5():
    a = rnd(-10, 10)
    b = rnd(-10, 10)
    c = rnd(-10, 10)
    lst = [a, b, c]
    lst.sort()
    return lst[1]


# print(timeit.timeit(stmt='version_1()', number=1000, globals=globals()))
# 0.0032734999999999986
# print(timeit.timeit(stmt='version_1()', number=1000000, globals=globals()))
# 3.3493235

# print(timeit.timeit(stmt='version_2()', number=1000, globals=globals()))
# 0.003331600000000004
# print(timeit.timeit(stmt='version_2()', number=1000000, globals=globals()))
# 3.5794913000000004

# print(timeit.timeit(stmt='version_3()', number=1000, globals=globals()))
# 0.015367699999999984
# print(timeit.timeit(stmt='version_3()', number=1000000, globals=globals()))
# 4.6147013

# print(timeit.timeit(stmt='version_4()', number=1000, globals=globals()))
# 0.0046861000000000125
# print(timeit.timeit(stmt='version_4()', number=1000000, globals=globals()))
# 3.2442165

# print(timeit.timeit(stmt='version_5()', number=1000, globals=globals()))
# 8.690000000000087e-05
# print(timeit.timeit(stmt='version_5()', number=1000000, globals=globals()))
# 0.0693572

def main(n):
    for i in range(n):
        #version_1()
        #version_2()
        #version_3()
        #version_4()
        version_5()


"""
cProfile.run('main(1000)')
ncalls  tottime  percall  cumtime  percall  filename:lineno(function)
1000    0.001    0.000    0.008    0.000    L_4_T_1.py:18(version_1)
1000    0.002    0.000    0.008    0.000    L_4_T_1.py:40(version_2)
1000    0.003    0.000    0.024    0.000    L_4_T_1.py:53(version_3)
1000    0.001    0.000    0.008    0.000    L_4_T_1.py:61(version_4)
   1    0.000    0.000    0.000    0.000    L_4_T_1.py:70(version_5)
"""

"""
cProfile.run('main(1000000)')
 ncalls  tottime  percall  cumtime  percall filename:lineno(function)
1000000    1.051    0.000    5.573    0.000 L_4_T_1.py:18(version_1)
1000000    1.150    0.000    5.649    0.000 L_4_T_1.py:40(version_2)
1000000    1.776    0.000    7.040    0.000 L_4_T_1.py:53(version_3)
1000000    1.075    0.000    5.755    0.000 L_4_T_1.py:61(version_4)
      1    0.000    0.000    0.000    0.000 L_4_T_1.py:70(version_5)
"""
