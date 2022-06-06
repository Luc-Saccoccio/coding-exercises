alphabet = set([chr(n) for n in range(97, 123)])

def is_pangram(sentence):
    transformed = filter(lambda l: l.isalpha(), sentence.lower())
    return set(transformed) == alphabet
