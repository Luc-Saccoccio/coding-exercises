from scipy.special import binom
from numpy import lcm

def trouver_somme(n):
    print(k := binom(2*n, n)/(n+1))
    print()


if __name__ == '__main__':
    n = int(input())
    trouver_somme(n)
