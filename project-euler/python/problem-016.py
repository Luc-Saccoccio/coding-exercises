# 2¹⁵ = 32768 and the sum of its digits is
# 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2¹⁰⁰⁰?

def solution():
    return sum(int(c) for c in str(1 << 1000))


if __name__ == '__main__':
    print(solution())
