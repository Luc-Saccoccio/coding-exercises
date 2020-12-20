def trouver_lettre(t, s):
    """
    :param t: taille de la séquence
    :type t: int
    :param s: liste des entiers que Hermès a sorti
    :type s: list[int]
    """
    if 65 <= s[0] <= 90:
        letter = chr((sum(s) - 65)%26 + 65)
        print(letter)
    else:
        print(' ')


if __name__ == '__main__':
    t = int(input())
    s = list(map(int, input().split()))
    trouver_lettre(t, s)
