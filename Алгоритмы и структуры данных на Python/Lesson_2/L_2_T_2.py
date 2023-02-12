"""
Посчитать четные и нечетные цифры введенного натурального числа.
Например, если введено число 34560, в нем 3 четные цифры (4, 6 и 0) и 2 нечетные (3 и 5).
"""

value = input('Ввод: ')
answer_1 = 0  # кол-во четные числа
answer_1_value = ''  # сами четные числа
answer_2 = 0  # кол-во нечетные числа
answer_2_value = ''  # сами нечетные числа

for i in value:
    check = int(i) % 2
    if check == 0:
        answer_1 += 1
        answer_1_value += i
    elif check == 1:
        answer_2 += 1
        answer_2_value += i
print('Вывод:')
print(f'- введено {answer_1} четных чисел: {answer_1_value}')
print(f'- введено {answer_2} не четных чисел: {answer_2_value}')

