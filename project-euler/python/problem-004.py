# A palindromic number reads the same both ways.
# The largest palindrome made from the product of two 2-digit
# numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of
# two 3-digit numbers.

def solution_v1() -> int:
    palindrome = 0
    for i in range(1000, 100, -1):
        for j in range(1000, i, -1):
            prod = i*j
            if str(prod) == str(prod)[::-1] and prod > palindrome:
                palindrome = prod
    return palindrome

def solution_v2() -> int:
    palindrome = 0
    for i in range(1000, 100, -1):
        b, db = (1000, 1) if not i%11 else (991, -11)
        for j in range(b, 100, db):
            prod = i*j
            if str(prod) == str(prod)[::-1] and prod > palindrome:
                palindrome = prod
    return palindrome

if __name__ == '__main__':
    print(solution_v2())
