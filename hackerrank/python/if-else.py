if __name__ == '__main__':
    n = int(input().strip())
    if n%2 or (n in range(6, 21) and not n%2):
        print("Weird")
    else:
        print("Not Weird")
