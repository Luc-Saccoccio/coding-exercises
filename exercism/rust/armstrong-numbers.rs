pub fn is_armstrong_number(num: u32) -> bool {
    let digits = num.to_string();
    let len = digits.len() as u32;
    num == digits.chars()
        .map(|c| c.to_digit(10).unwrap())
        .map(|d| d.pow(len))
        .sum()
}
