# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?


def solution1(n: int) -> list:
    factors = []
    d = 2
    while n > 1:
        while n % d == 0:
            factors.append(d)
            n /= d
        d += 1
        if d*d > n:
            if n > 1: factors.append(n)
            break
    return factors


def solution2(n: int) -> int:
    i = 2
    while i < n:
        while n%i == 0:
            n /= i
        i += 1
    return n


if __name__ == '__main__':
    # print(max(solution1(600851475143)))
    print(solution2(600851475143))
