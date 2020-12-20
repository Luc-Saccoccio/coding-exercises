import itertools

with open('input', 'r') as f:
    numbers = [int(line) for line in f.readlines()]

for couple in itertools.combinations(numbers, 2):
    if sum(couple) == 2020:
        print(couple[0] * couple[1])
        break
