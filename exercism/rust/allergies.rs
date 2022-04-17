#[derive(Debug, PartialEq, Copy, Clone)]
pub enum Allergen {
    Eggs = 1 << 0,
    Peanuts = 1 << 1,
    Shellfish = 1 << 2,
    Strawberries = 1 << 3,
    Tomatoes = 1 << 4,
    Chocolate = 1 << 5,
    Pollen = 1 << 6,
    Cats = 1 << 7,
}

static ALLERGENS: [Allergen; 8] = {
    use self::Allergen::*;
    [
        Eggs,
        Peanuts,
        Shellfish,
        Strawberries,
        Tomatoes,
        Chocolate,
        Pollen,
        Cats,
    ]
};

pub struct Allergies {
    allergens: u32,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies { allergens: score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        let a = *allergen as u32;
        self.allergens & a == a
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        ALLERGENS
            .iter()
            .filter(|x| self.is_allergic_to(x))
            .cloned()
            .collect::<Vec<Allergen>>()
    }
}
