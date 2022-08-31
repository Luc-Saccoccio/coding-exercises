use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    let mut res = nucleotide_counts(dna)?;
    res.remove(&nucleotide).ok_or(nucleotide)
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut res: HashMap<char, usize> = ['A', 'T', 'G', 'C'].iter().map(|n| (*n, 0)).collect();
    for c in dna.chars() {
        res.get_mut(&c).map(|count| *count += 1).ok_or(c)?
    }
    Ok(res)
}
