from itertools import product

def dijkstra(graph, initial, target):
    path, adj_node, queue, liste = {}, {}, [], []
    for node in graph:
        path[node] = float("inf")
        adj_node[node] = None
        queue.append(node)
    path[initial] = 0
    while queue:
        key_min = queue[0]
        min_val = path[key_min]
        for i in range(1, len(queue)):
            if path[queue[i]] < min_val:
                key_min = queue[i]
                min_val = path[key_min]
        cur = key_min
        queue.remove(cur)
        for i in graph[cur]:
            alternate = graph[cur][i] + path[cur]
            if path[i] > alternate:
                path[i] = alternate
                adj_node[i] = cur
    cout = path[target]
    while True:
        target = adj_node[target]
        if target is None or target == initial:
            break
        liste.append(target[1])
    return liste, cout


def labyrinthe_demoniaque(ame, n, m, plateau):
    graph = {}
    graph['S'] = {(0, y): plateau[0][y] for y in range(m)}
    for x, y in product(range(n), range(m)):
        if y == 0:
            dispos = range(2)
        elif y == (m-1):
            dispos = range(m-2, m)
        else:
            dispos = range(y, y+2)
        graph[(x, y)] = {(x+1, z): plateau[x+1][z] for z in dispos} if x != (n-1) else {'E': 0}
    graph['E'] = {}
    path, cout = dijkstra(graph, 'S', 'E')
    if cout > ame:
        return 'IMPOSSIBLE'
    else:
        return reversed(path)


if __name__ == '__main__':
    ame = int(input())
    n = int(input())
    m = int(input())
    plateau = [list(map(int, input().split())) for _ in range(n)]
    print(' '.join(map(str, reversed(labyrinthe_demoniaque(ame, n, m, plateau)))))
