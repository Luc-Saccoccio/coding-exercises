# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is
# 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

def factorial(n: int) -> int:
    return 1 if n == 1 else n*factorial(n-1)

def solution1():
    return sum(int(i) for i in str(factorial(100)))

def solution2():
    S = 1
    for i in range(1, 101):
        if i%10 == 0:
            S *= i//10
        else:
            S *= i
        print(S)
    return sum(int(i) for i in str(S))

if __name__ == '__main__':
    print(solution2())
