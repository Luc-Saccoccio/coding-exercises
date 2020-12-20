# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
# we can see that the 6th prime is 13.
# What is the 10 001st prime number?

def is_prime(n: int) -> bool:
    if n <= 3: return n > 1
    elif not(n%2 and n%3): return False

    i = 5
    while i**2 <= n:
        if not(n%i and n%(i+2)): return False
        i += 6
    return True

def solution(number: int) -> int:
    i, count = 1, 0
    while count != number:
        if is_prime(i):
            count += 1
            prime = i
        i += 2
    return prime

if __name__ == '__main__':
    print(solution(10001))
