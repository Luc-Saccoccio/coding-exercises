# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
# What is the total of all the name scores in the file?

def solution():
    with open('problem-022-input.txt', 'r') as file:
        liste = [name.replace('"', '') for name in file.readline().split(',')]
    liste[-1] = liste[-1].replace('\n', '')
    liste.sort()
    return sum((i+1) * (ord(c) - ord('A') + 1)
		for (i, name) in enumerate(liste)
		for c in name)

print(solution())
