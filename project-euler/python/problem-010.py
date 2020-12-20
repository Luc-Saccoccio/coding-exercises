# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

def is_prime(n: int) -> bool:
    if n <= 3: return n > 1
    elif not n%2 or not n%3: return False

    i = 5
    while i**2 <= n:
        if not n%i or not n%(i+2): return False
        i += 6
    return True


def solution():
    primes = [x for x in range(2000000) if is_prime(x)]
    return sum(primes)


if __name__ == '__main__':
    print(solution())
