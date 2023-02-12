"""
1. На улице встретились N друзей. Каждый пожал руку всем остальным друзьям (по одному разу). Сколько рукопожатий было?
Примечание. Решите задачу при помощи построения графа.
"""


import pandas as pd


n = int(input(f'Введите колличество человек: '))

graph = pd.DataFrame([[1 if i > j else 0 for i in range(n)] for j in range(n)])

print(graph)
print(f'Количество рукопожатий {sum(sum(graph.values))}')

