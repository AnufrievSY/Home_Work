"""
1. Пользователь вводит данные о количестве предприятий, их наименования и прибыль за четыре квартала
для каждого предприятия. Программа должна определить среднюю прибыль (за год для всех предприятий) и
отдельно вывести наименования предприятий, чья прибыль выше среднего и ниже среднего.
"""

from collections import Counter, defaultdict, OrderedDict


def new(base_):
    name = input('Наименования организации: ')
    for i in range(1, 5):
        value = int(input(f'Прибыль за {i} месяц: '))
        base_[name].append(value)
    return base_


def result(base_):
    base_counting = Counter()
    for key, values in base_.items():
        base_counting += Counter({key: sum(values)})

    mean = sum(base_counting.values()) / len(base_counting)
    more = Counter()
    less = Counter()
    for key, value in base_counting.items():
        if value >= mean:
            more += {key: value}
        elif value < mean:
            less += {key: value}

    more = OrderedDict(sorted(more.items(), key=lambda x: x[1]))
    less = OrderedDict(sorted(less.items(), key=lambda x: x[1]))

    print(f'Средняя прибыль: {mean}')
    print(f'Больше среднего: {more}')
    print(f'Меньше среднего: {less}')


base = defaultdict(list)
while True:
    print('Доступные команды: new, result, end')
    command = input('Введите команду: ')
    if command == 'new':
        base = new(base)
    elif command == 'result':
        result(base)
    elif command == 'end':
        break
    print('\n', '*' * 50, '\n')
