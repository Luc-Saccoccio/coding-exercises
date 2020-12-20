def lcm(x, y):
    greater = [y, x][x > y]
    while(True):
        if((greater % x == 0) and (greater % y == 0)):
            lcm = greater
            break
        greater += 1
    return lcm

def binom(n, k): 
    res = 1
    for i in range(k): 
        res = res * (n - i) 
        res = res / (i + 1) 
    return res 
  
def catalan(n): 
    c = binom(2*n, n) 
    return c/(n + 1) 

def trouver_somme(n):
    print(k := int(catalan(n-1)))
    print(sum(sum(lcm(i, j) for j in range(1, k+1)) for i in range(1, k+1)))


if __name__ == '__main__':
    n = int(input())
    trouver_somme(n)
