"""
1. Определение количества различных подстрок с использованием хеш-функции. Пусть на вход функции дана строка.
Требуется вернуть количество различных подстрок в этой строке.
Примечания:
* в сумму не включаем пустую строку и строку целиком;
* без использования функций для вычисления хэша (hash(), sha1() или любой другой из модуля hashlib задача
считается не решённой.
"""

import hashlib


def substring_count(string):
    string = str(string).replace(' ', '')
    length = len(string)
    hash_set = set()

    for i in range(length + 1):
        for j in range(i + 1, length + 1):
            if string[i:j] != string:
                hash_set.add(hashlib.sha1(string[i:j].encode('utf-8')).hexdigest())

    return len(hash_set)


value = 'Hello World!'

print(f'Количество различных подстрок в строке {value}: {substring_count(value)}')
