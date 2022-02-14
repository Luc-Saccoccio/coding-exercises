use enum_iterator::IntoEnumIterator;
use int_enum::IntEnum;

#[repr(u8)]
#[derive(Debug, Copy, Clone, PartialEq, IntEnum, IntoEnumIterator)]
pub enum ResistorColor {
    Black = 0,
    Brown = 1,
    Red = 2,
    Orange = 3,
    Yellow = 4,
    Green = 5,
    Blue = 6,
    Violet = 7,
    Grey = 8,
    White = 9,
}

pub fn color_to_value(color: ResistorColor) -> usize {
    color.int_value().into()
}

pub fn value_to_color_string(value: usize) -> String {
    if value > 9 { String::from("value out of range") } else {
        format!("{:?}", ResistorColor::from_int(value as u8).unwrap())
    }
}

pub fn colors() -> Vec<ResistorColor> {
    ResistorColor::into_enum_iter().collect::<Vec<ResistorColor>>()
}
