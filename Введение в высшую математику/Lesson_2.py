from math import sqrt

vector_1 = [10, 10, 10]
vector_2 = [0, 0, -10]
vector_sum = [vector_1[i]+vector_2[i] for i in range(len(vector_1))]
vector_1_length = round(sqrt(sum([pow(x, 2) for x in vector_1])), 2)
vector_2_length = round(sqrt(sum([pow(x, 2) for x in vector_2])), 2)
vector_sum_length = round(sqrt(sum([pow(x, 2) for x in vector_sum])), 2)

print(f'Вектор 1 = {vector_1}\n'
      f'Вектор 2 = {vector_2}\n'
      f'Сумма 1 и 2 векторов = {vector_sum}\n'
      f'Длинна вектора 1 = {vector_1_length}\n'
      f'Длинна вектора 2 = {vector_2_length}\n'
      f'Длинна суммы векторов 1 и 2 = {vector_sum_length}\n')
