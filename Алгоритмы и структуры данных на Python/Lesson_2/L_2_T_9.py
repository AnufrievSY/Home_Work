"""
Среди натуральных чисел, которые были введены, найти наибольшее по сумме цифр.
Вывести на экран это число и сумму его цифр.
"""

value = input('Ввод: ')
answer = ''
sum_answer = 0
for i in value.split(', '):
    sum_i = 0
    for j in i:
        sum_i += int(j)
    if sum_i > sum_answer:
        answer = i
        sum_answer = sum_i
print(f'Наиболее по сумме цифр число: {answer}\nСумма его цифр: {sum_answer}')
