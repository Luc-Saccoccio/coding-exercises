#[derive(Debug, PartialEq)]
pub struct Dna(String);

#[derive(Debug, PartialEq)]
pub struct Rna(String);

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        match dna.find(|c| !"ATGC".contains(c)) {
            Some(e) => Err(e),
            None => Ok(Dna(String::from(dna))),
        }
    }

    pub fn into_rna(self) -> Rna {
        Rna(self.0
            .chars()
            .map(|c| match c {
                'A' => 'U',
                'T' => 'A',
                'G' => 'C',
                'C' => 'G',
                _ => unreachable!()
            }).collect())
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        match rna.find(|c| !"AUGCU".contains(c)) {
            Some(e) => Err(e),
            None => Ok(Rna(String::from(rna))),
        }
    }
}
