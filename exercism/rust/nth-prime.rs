pub fn nth(n: u32) -> u32 {
    let mut primes: Vec<u32> = vec![2, 3, 5, 7, 11, 13];
    let mut candidate = 17;
    let n = n as usize;
    while primes.len() <= n {
        while (&primes)
            .iter()
            // .take_while(|p| p * p <= candidate)
            .any(|p| candidate % p == 0)
        {
            candidate += 2
        }
        primes.push(candidate);
        candidate += 2;
    }
    *primes.iter().nth(n).unwrap()
}
