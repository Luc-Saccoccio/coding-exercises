# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
# Although it has not been proved yet (Collatz Problem),
# it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.

def collatz(n: int) -> int:
    u = lambda x: 3*x + 1 if x%2 else x//2
    i = 0
    while n != 1:
        n = u(n)
        i += 1
    return i


def solution():
    maxi = 1
    for i in range(2, 1000000):
        if collatz(i) > maxi:
            maxi = collatz(i)
            number = i
    return number


def solution2():
    def count_chain(n: int):
        if n in values: return values[n]
        if n%2:
            values[n] = 2 + count_chain((3*n +1)//2)
        else:
            values[n] = 1 + count_chain(n//2)
        return values[n]
    maxi = 0
    ans = -1
    values = {1: 1}
    for i in range(500000,1000000):
        n = count_chain(i)
        if n > maxi:
            maxi = n
            ans = i
    return ans


if __name__ == '__main__':
    print(solution2())
