"""
2. Доработать алгоритм Дейкстры (рассматривался на уроке), чтобы он дополнительно
возвращал список вершин, которые необходимо обойти.
"""

from collections import deque


def dijkstra(graph, start):
    length = len(graph)
    is_visited = [False] * length
    parent = [-1] * length
    cost = [float('inf')] * length
    path = []

    cost[start] = 0
    min_cost = 0

    while min_cost < float('inf'):
        is_visited[start] = True

        for i, vertex in enumerate(graph[start]):

            if vertex != 0 and not is_visited[i]:

                if cost[i] > vertex + cost[start]:
                    cost[i] = vertex + cost[start]
                    parent[i] = start

        min_cost = float('inf')
        for i in range(length):
            if min_cost > cost[i] and not is_visited[i]:
                min_cost = cost[i]
                start = i

    for i in range(length):
        if parent[i] == -1:
            path.append('error')
        elif parent[i] == 0:
            path.append([parent[i], i])
        elif parent[parent[i]] == 0:
            path.append([0, parent[i], i])
        else:
            path.append([0, parent[parent[i]], parent[i], i])

    return cost, path


g = [
    [0, 0, 1, 1, 9, 0, 0, 0],
    [0, 0, 9, 4, 0, 0, 5, 0],
    [0, 9, 0, 0, 3, 0, 6, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0, 5, 0],
    [0, 0, 7, 0, 8, 1, 0, 0],
    [0, 0, 0, 0, 0, 1, 2, 0]
    ]
s = int(input("От какой вершины идти: "))

c, p = dijkstra(g, s)
for i in range(len(p)):
    if i == s:
        print(f'{i} - стартовая вершина.')
    elif p[i] == 'error':
        print(f'Путь от вершины {s} до вершины {i} не существует.')
    else:
        print(f'Путь от вершины {s} до вершины {i}: {p[i]}, а стоимость: {c[i]} условных единиц.')


