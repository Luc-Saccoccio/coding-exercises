pub fn series(digits: &str, len: usize) -> Vec<String> {
    let mut res: Vec<String> = Vec::new();
    if let Some(n) = digits.len().checked_sub(len) {
        for i in 0..=n {
            res.push(digits[i..i + len].to_string())
        }
    }
    res
}
