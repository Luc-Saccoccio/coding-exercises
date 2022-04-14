pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let (mut a, mut b): (usize, usize) = (0, array.len());
    while a < b {
        let c: usize = (a + b) / 2;
        if array[c] < key {
            a = c + 1
        } else if array[c] > key {
            b = c
        } else {
            return Some(c);
        }
    }
    None
}
