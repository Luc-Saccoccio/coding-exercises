dico = {'G': 'C',
        'C': 'G',
        'T': 'A',
        'A': 'U'}

def translate(char):
    return dico[char]


def to_rna(dna_strand):
    res = ""
    for w in dna_strand:
        res += translate(w)
    return res
