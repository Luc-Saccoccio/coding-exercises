
// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut words: HashMap<&str, i16> = HashMap::with_capacity(magazine.len());
    for m in magazine {
        *words.entry(*m).or_default() += 1;
    }

    for n in note {
        *words.entry(*n).or_default() -= 1;
        if words[n] < 0 {
            return false;
        }
    }
    true
}
