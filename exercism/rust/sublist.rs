#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(f: &[T], s: &[T]) -> Comparison {
    use Comparison::*;
    match (f.len(), s.len()) {
        (0, 0) => Equal,
        (0, _) => Sublist,
        (_, 0) => Superlist,
        (m, n) if m > n => {
            if f.windows(n).any(|w| w == s) {
                Superlist
            } else {
                Unequal
            }
        }
        (m, n) if n > m => {
            if s.windows(m).any(|w| w == f) {
                Sublist
            } else {
                Unequal
            }
        }
        (_, _) => {
            if f == s {
                Equal
            } else {
                Unequal
            }
        }
    }
}
