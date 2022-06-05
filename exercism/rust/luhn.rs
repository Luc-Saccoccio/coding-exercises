/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let mut n = 0;
    let mut l = 0;
    for x in code.chars().rev() {
        if let Some(y) = x.to_digit(10) {
            if l % 2 == 0 {
                n += y
            } else {
                n += if y > 4 { y * 2 - 9 } else { y * 2 }
            }
            l += 1;
        } else if !x.is_whitespace() {
            return false;
        }
    }
    l > 1 && n % 10 == 0
}
