import functools

def digits(n):
    res = []
    while n != 0:
        res.append(n%10)
        n = n // 10
    return res

def is_armstrong_number(number):
    dgs = digits(number)
    l = len(dgs)
    return number == functools.reduce((lambda acc, x: acc + x ** l), dgs, 0)
