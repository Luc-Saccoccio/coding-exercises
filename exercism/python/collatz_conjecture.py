def f(n):
    if n%2:
        return 3*n+1
    return n//2

def steps(number):
    if number <= 0:
        raise ValueError("Only positive integers are allowed")
    res = 0
    while number != 1:
        number = f(number)
        res += 1
    return res
