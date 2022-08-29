def distance(strand_a, strand_b):
    la, lb = len(strand_a), len(strand_b)
    if la != lb:
        raise ValueError("Strands must be of equal length.")
    return sum(i != j for (i, j) in zip(strand_a, strand_b))
