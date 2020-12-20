import re

passwords = []
good = 0
with open('input', 'r') as f:
    for i in range(1000):
        line = (f.readline().split(sep=':'))
        condition = line[0].split()
        password = line[1].rstrip(' \n')
        passwords.append((condition, password))

for password in passwords:
    num = len(re.findall(password[0][1], password[1]))
    low, high = map(int, password[0][0].split(sep='-'))
    good += num in range(low, high+1)

print(good)
