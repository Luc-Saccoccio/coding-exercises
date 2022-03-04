pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    (1..limit)
        .filter(|&i| factors.iter().filter(|&&j| j != 0).any(|&j| i % j == 0))
        .sum()
}
