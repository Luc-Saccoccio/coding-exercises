pub fn encode(source: &str) -> String {
    let mut res = String::new();
    let mut characters = source.chars().peekable();
    let mut count = 0;
    while let Some(curr) = characters.next() {
        count += 1;
        if characters.peek() != Some(&curr) {
            if count > 1 {
                res.push_str(&count.to_string());
            }
            res.push(curr);
            count = 0;
        }
    }
    res
}

pub fn decode(source: &str) -> String {
    let mut res = String::new();
    let mut nums = String::new();
    for c in source.chars() {
        if c.is_numeric() {
            nums.push(c)
        } else {
            res.push_str(&c.to_string().repeat(nums.parse::<usize>().unwrap_or(1)));
            nums.clear();
        }
    }
    res
}
