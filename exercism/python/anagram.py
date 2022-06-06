def raw(word):
    return sorted(word.lower())

def find_anagrams(word, candidates):
    letters = raw(word)
    for w in candidates:
        if raw(w) == letters and w.lower() != word.lower():
            yield w
