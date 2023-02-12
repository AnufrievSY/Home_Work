"""
3. Написать программу, которая обходит не взвешенный ориентированный граф без петель, в котором все вершины связаны,
по алгоритму поиска в глубину (Depth-First Search).
Примечания:
a. граф должен храниться в виде списка смежности;
b. генерация графа выполняется в отдельной функции, которая принимает на вход число вершин.
"""

import random


def graph(n):
    g = [[]] * n
    v_list = [i for i in range(n)]

    for i in range(n):
        count = 0
        while count == 0:
            presence = [random.randint(0, 1) for i in range(n-1)]
            random.shuffle(presence)
            new_list = v_list.copy()
            new_list.remove(i)
            for index, element in enumerate(new_list):
                if presence[index] == 1:
                    g[i] = g[i] + [element]
                    count += 1
    return g


def doDFS(g):
    n = len(g)
    is_visited = [False for i in range(n)]
    print(f'Начальное состояние прохода по вершинам: {is_visited}')

    def dfs(node):
        is_visited[node] = True
        for vertex in g[node]:
            if not is_visited[vertex]:
                dfs(vertex)

    for i in range(n):
        if not is_visited[i]:
            dfs(i)

    return is_visited


n = int(input('Сколько вершин: '))
g = graph(n)
print('Граф:')
for i in range(n):
    print(g[i])
print(doDFS(g))
