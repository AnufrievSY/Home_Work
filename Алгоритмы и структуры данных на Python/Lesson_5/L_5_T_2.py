"""
2. Написать программу сложения и умножения двух шестнадцатеричных чисел.
При этом каждое число представляется как массив, элементы которого — цифры числа.
Например, пользователь ввёл A2 и C4F. Нужно сохранить их как [‘A’, ‘2’] и [‘C’, ‘4’, ‘F’] соответственно.
Сумма чисел из примера: [‘C’, ‘F’, ‘1’], произведение - [‘7’, ‘C’, ‘9’, ‘F’, ‘E’].
Примечание: Если воспользоваться функциями hex() и/или int() для преобразования систем счисления,
задача решается в несколько строк. Для прокачки алгоритмического мышления такой вариант не подходит.
Поэтому использование встроенных функций для перевода из одной системы счисления в другую в данной задаче под запретом.
Вспомните начальную школу и попробуйте написать сложение и умножение в столбик.
"""

from collections import deque, OrderedDict

dict_16 = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9,
           'A': 10, 'B': 11, 'C': 12, 'D': 13, 'E': 14, 'F': 15,
           0: '0', 1: '1', 2: '2', 3: '3', 4: '4', 5: '5', 6: '6', 7: '7', 8: '8', 9: '9',
           10: 'A', 11: 'B', 12: 'C', 13: 'D', 14: 'E', 15: 'F'}


def sum_hex(x, y):
    result = deque()
    transfer = 0

    y, x = [deque(i) for i in OrderedDict(sorted([('x', x), ('y', y)], key=lambda t: len(t[1]))).values()]

    while x:
        if y:
            res = dict_16[x.pop()] + dict_16[y.pop()] + transfer
        else:
            res = dict_16[x.pop()] + transfer
        transfer = 0

        if res < 16:
            result.appendleft(dict_16[res])
        else:
            result.appendleft(dict_16[res - 16])
            transfer = 1

    if transfer:
        result.appendleft('1')

    return list(result)


def mult_hex(x, y):
    result = deque()
    spam = deque([deque() for _ in range(len(y))])
    x, y = x.copy(), deque(y)

    for i in range(len(y)):
        m = dict_16[y.pop()]
        for j in range(len(x) - 1, -1, -1):
            spam[i].appendleft(m * dict_16[x[j]])
        for _ in range(i):
            spam[i].append(0)
    transfer = 0

    for _ in range(len(spam[-1])):
        res = transfer
        for i in range(len(spam)):
            if spam[i]:
                res += spam[i].pop()

        if res < 16:
            result.appendleft(dict_16[res])
        else:
            result.appendleft(dict_16[res % 16])
            transfer = res // 16

    if transfer:
        result.appendleft(dict_16[transfer])

    return list(result)


a = list(input('Введите 1-е шестнадцатиричное число: ').upper())
b = list(input('Введите 2-е шестнадцатиричное число: ').upper())

print(*a, '+', *b, '=', *sum_hex(a, b))
print(*a, '*', *b, '=', *mult_hex(a, b))
