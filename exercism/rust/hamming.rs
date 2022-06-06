use std::iter::zip;


/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.len() != s2.len() { return None } else {
        let mut res = 0;
        for (x, y) in zip(s1.chars(), s2.chars()) {
            if x != y { res += 1 };
        }; Some(res)
    }
}
