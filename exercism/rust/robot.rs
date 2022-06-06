// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

#[derive(PartialEq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

pub struct Robot {
    x: i32,
    y: i32,
    d: Direction,
}

impl Robot {
    pub fn new(x: i32, y: i32, d: Direction) -> Self {
        Robot { x, y, d }
    }

    #[must_use]
    pub fn turn_right(self) -> Self {
        match self.d {
            Direction::North => Self { d: Direction::East, ..self },
            Direction::East => Self { d: Direction::South, ..self },
            Direction::South => Self { d: Direction::West, ..self },
            Direction::West => Self { d: Direction::North, ..self },
        }
    }

    #[must_use]
    pub fn turn_left(self) -> Self {
        match self.d {
            Direction::North => Self { d: Direction::West, ..self },
            Direction::East => Self { d: Direction::North, ..self },
            Direction::South => Self { d: Direction::East, ..self },
            Direction::West => Self { d: Direction::South, ..self },
        }
    }

    #[must_use]
    pub fn advance(self) -> Self {
        match self.d {
            Direction::North => Self { y: self.y + 1, ..self },
            Direction::East => Self { x: self.x + 1, ..self },
            Direction::South => Self { y: self.y - 1, ..self },
            Direction::West => Self { x: self.x - 1, ..self },
        }
    }

    #[must_use]
    pub fn instructions(self, instructions: &str) -> Self {
        instructions.chars().fold(self, |acc, c| acc.step(c))
    }

    pub fn step(self, c: char) -> Self {
        match c {
            'R' => self.turn_right(),
            'A' => self.advance(),
            'L' => self.turn_left(),
            _ => unreachable!()
        }
    }

    pub fn position(&self) -> (i32, i32) {
        (self.x, self.y)
    }

    pub fn direction(&self) -> &Direction {
        &self.d
    }
}
