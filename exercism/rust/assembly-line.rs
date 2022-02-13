// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

const PRODUCTION_RATE: f64 = 221.;

pub fn production_rate_per_hour(speed: u8) -> f64 {
    f64::from(speed) * PRODUCTION_RATE *
    if (speed <= 4) {
        1.0_f64
    } else if (speed <= 8) {
        0.9_f64
    } else {
        0.77_f64
    }
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed)/60.) as u32
}
