pub fn collatz(n: u64) -> Option<u64> {
    if n < 1 {
        return None;
    };
    let mut r = 0;
    let mut n = n;
    while n != 1 {
        r += 1;
        if n % 2 == 0 {
            n = n / 2
        } else {
            n = n.checked_mul(3)?.checked_add(1)?
        }
    }
    Some(r)
}
