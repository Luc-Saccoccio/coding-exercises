def genealogie_divine(f, m, familles, c, cartes):
    return min(len(set(fam) - set(cartes)) for fam in familles)


if __name__ == '__main__':
    f = int(input())
    m = int(input())
    familles = [list(input()) for _ in range(f)]
    c = int(input())
    cartes = list(input())
    print(genealogie_divine(f, m, familles, c, cartes))
