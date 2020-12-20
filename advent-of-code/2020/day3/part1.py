# from functools import reduce
# reduce(lambda x, y : x if abs(y) > abs(x) else y, your_sequence)

with open('input', 'r') as f:
    lines = [line.strip() for line in f.readlines()]

count = 0
row, col = 0, 0
width, height = len(lines[0]), len(lines)
while row+1 < height:
    row += 1
    col += 3
    count += lines[row][col%width] == '#'

print(count)
