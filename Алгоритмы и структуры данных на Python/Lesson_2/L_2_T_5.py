"""
Вывести на экран коды и символы таблицы ASCII, начиная с символа под номером 32 и заканчивая 127-м включительно.
Вывод выполнить в табличной форме: по десять пар «код-символ» в каждой строке.
"""

import pandas as pd

# Сброс ограничений на количество выводимых рядов
pd.set_option('display.max_rows', None)

# Сброс ограничений на число столбцов
pd.set_option('display.max_columns', None)

# Сброс ограничений на количество символов в записи
pd.set_option('display.max_colwidth', None)

df = pd.DataFrame()
x = 1
y = 1

for i in range(32, 128):
    df.loc[x, y] = f'{i} - {chr(i)}'
    y += 1
    if y == 11:
        x += 1
        y = 1

df = df.fillna('')

print(df)
