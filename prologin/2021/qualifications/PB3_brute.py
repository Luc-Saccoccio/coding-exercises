import random
from PB3 import dijkstra, labyrinthe_demoniaque

def all_paths(plateau, r, i):
    if r == len(plateau)-1:
        return [[plateau[r][i]]]
    else:
        paths = []
        for j in range(max(0, i-1), min(i+2, len(plateau[0]))):
            paths.extend(all_paths(plateau, r+1, j))
        return [[plateau[r][i]] + p for p in paths]

def brute(a, n, m, plateau):
    chemins = []
    for i in range(m):
        chemins.extend(all_paths(plateau, 0, i))
    minimum = sum(min(chemins, key=lambda c: sum(c)))
    if minimum > a:
        return [[]]
    return list(filter(lambda c:sum(c)==minimum, chemins))

if __name__ == '__main__':
    while True:
        all_tracks = []
        ame = 5000
        n = random.randint(2, 10)
        m = random.randint(2, 10)
        plateau = [[random.randint(0, 100) for _ in range(m)] for _ in range(n)]
        path = [plateau[x][y] for x, y in enumerate(map(int, labyrinthe_demoniaque(ame, n, m, plateau).split()))]
        all_path = brute(ame, n, m, plateau)
        if not path in all_path:
            print('ERROR')
            print(f'Paramètres : ame={ame}, n={n}, m={m}')
            print('Grille : [')
            for line in plateau:
                print(' '.join(map(str, line)))
            print(']')
            print('Chemins :', all_path)
            print('Chemin trouvé :', path)
            break
        else:
            print('FINE')
