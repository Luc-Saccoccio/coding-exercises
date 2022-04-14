use std::iter::once;

pub fn build_proverb(list: &[&str]) -> String {
    match list.first() {
        None => String::new(),
        Some(f) => list
            .windows(2)
            .map(|word| format!("For want of a {} the {} was lost.\n", word[0], word[1]))
            .chain(once(format!("And all for the want of a {}.", f)))
            .collect(),
    }
}
