# If we list all the natural numbers below 10 that are multiples of 3 or 5,
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.



def somme_divisible(n: int) -> int:
    p = 999//n
    return n*(p*(p+1)) //2


def solution_v1() -> int:
    S = 0
    for i in range(1, 1000):
        if not i%3 or not i%5:
            S += i
    return S


def solution_v2() -> int:
    return somme_divisible(3)+somme_divisible(5)-somme_divisible(15)

if __name__ == '__main__':
    # print(solution_v1())
    print(solution_v2())
