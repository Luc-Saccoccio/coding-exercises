cube = lambda x: x**3

def fibonacci(n):
    fibs = [0, 1]
    for i in range(2, n):
        fibs.append(fibs[-1] + fibs[-2])
    return fibs[0:n]

if __name__ == '__main__':
    n = int(input())
    print(list(map(cube, fibonacci(n))))
