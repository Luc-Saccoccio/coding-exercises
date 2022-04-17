const MINE: u8 = b'*';
type Map = Vec<Vec<u8>>;

pub fn annotate(field: &[&str]) -> Vec<String> {
    let parsed = field
        .iter()
        .map(|&line| line.bytes().collect::<Vec<u8>>())
        .collect::<Map>();

    let ly = parsed.len() as i8;
    let lx = parsed.first().unwrap_or(&vec![]).len() as i8;

    parsed
        .iter()
        .enumerate()
        .map(|(y, row)| {
            row.iter()
                .enumerate()
                .map(|(x, cell)| {
                    if *cell == MINE {
                        '*'
                    } else {
                        count_mines(&parsed, x as i8, y as i8, lx, ly)
                    }
                })
                .collect()
        })
        .collect()
}

fn count_mines(map: &Map, x: i8, y: i8, lx: i8, ly: i8) -> char {
    let mut n = 0;
    for dy in [-1, 0, 1] {
        for dx in [-1, 0, 1] {
            let x_ = x + dx;
            let y_ = y + dy;
            if x_ >= 0 && x_ < lx && y_ >= 0 && y_ < ly && map[y_ as usize][x_ as usize] == MINE {
                n += 1;
            }
        }
    }
    if n == 0 {
        ' '
    } else {
        ('0' as u8 + n) as char
    }
}
