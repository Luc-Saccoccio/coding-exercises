use std::collections::HashSet;

/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let alphabet: HashSet<char> = HashSet::from_iter("abcdefghijklmnopqrstuvwxyz".chars());
    let letters: HashSet<char> = HashSet::from_iter(sentence.to_lowercase().chars());
    return alphabet.is_subset(&letters)
}
