# from functools import reduce
# reduce(lambda x, y : x if abs(y) > abs(x) else y, your_sequence)

with open('input', 'r') as f:
    lines = [line.strip() for line in f.readlines()]

count1, count2, count3, count4, count5 = 0, 0, 0, 0, 0
row1, row2 = 0, 0
col1, col3, col5, col7 = 0, 0, 0, 0
width, height = len(lines[0]), len(lines)
while row1+1 < height:
    row1 += 1
    col1 += 1
    col3 += 3
    col5 += 5
    col7 += 7
    count1 += lines[row1][col1%width] == '#'
    count2 += lines[row1][col3%width] == '#'
    count3 += lines[row1][col5%width] == '#'
    count4 += lines[row1][col7%width] == '#'

col1 = 0
while row2+1 < height:
    row2 +=2
    col1 +=1
    count5 += lines[row2][col1%width] == '#'

print(count1*count2*count3*count4*count5)
