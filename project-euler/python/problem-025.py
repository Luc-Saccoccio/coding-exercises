def solution():
    fibs = [1, 1]
    while fibs[-1] < 10**999:
        fibs.append(fibs[-1] + fibs[-2])
    return len(fibs)

if __name__ == '__main__':
    print(solution())
