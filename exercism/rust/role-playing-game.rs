// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {
        if self.health == 0 {
            Some(Player {
                health:100,
                mana: if self.level >= 10 { Some(100) } else { None },
                level: self.level }
            )
        } else { None }
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        match self.mana as Option<u32> {
            None => { self.health = self.health.saturating_sub(mana_cost); 0 },
            Some(x) => if x < mana_cost { 0 } else {
                self.mana = Some(x - mana_cost); 2*mana_cost
            }
        }
    }
}
