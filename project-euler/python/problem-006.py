# Find the difference between the sum of the squares of the
# first one hundred natural numbers and the square of the sum.
def solution_v1(n: int) -> int:
    sq = lambda x: x*x
    squares_sum = sum(map(sq, range(1, n+1)))
    sum_squares = sum(range(1, n+1))**2
    return sum_squares - squares_sum

def solution_v2(n: int) -> int:
    squares_sum = (2*n+1)*(n+1)*(n/6)
    sum_squares = (n+1)*(n/2)
    return sum_squares**2 - squares_sum

if __name__ == '__main__':
    print(solution_v1(100))
