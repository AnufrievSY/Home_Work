"""
Определить, какое число в массиве встречается чаще всего.
"""

from random import randrange as rnd

num_list = [rnd(0, 10) for _ in range(10)]
print(f'Изначальный список: {num_list}')

answer_dict = {}
for i in num_list:
    key = i
    value = 0
    for j in num_list:
        if j == i:
            value += 1
    answer_dict[key] = value

answer_key = 0
answer_value = 0
for key, value in answer_dict.items():
    if value > answer_value:
        answer_key = key
        answer_value = value
print(f'Чаще всего в списке встречается число {answer_key} - {answer_value} раз.')


