use std::{collections::HashSet, char};

fn anagram(a: &str, b: &str) -> bool {
    if a.len() != b.len() { return false }
    let mut a: Vec<char> = a.to_lowercase().chars().collect();
    let mut b: Vec<char> = b.to_lowercase().chars().collect();

    if a != b {
        a.sort_unstable(); b.sort_unstable();
        return a.eq(&b)
    }
    false
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &'a [&'a str]) -> HashSet<&'a str> {
    let mut valid_words: HashSet<&'a str> = HashSet::new();

    for possible in possible_anagrams {
        if anagram(word, possible) {
            valid_words.insert(possible);
        }
    }
    valid_words
}
