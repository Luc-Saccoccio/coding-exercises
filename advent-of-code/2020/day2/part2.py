passwords = []
good = 0
with open('input', 'r') as f:
    for i in range(1000):
        line = (f.readline().split(sep=':'))
        condition = line[0].split()
        password = line[1].rstrip(' \n')
        passwords.append((condition, password))

for password in passwords:
    pos1, pos2 = map(int, password[0][0].split(sep='-'))
    good += ((password[1][pos1] == password[0][1] and password[1][pos2] != password[0][1])
            or (password[1][pos1] != password[0][1] and password[1][pos2] == password[0][1]))

print(good)
