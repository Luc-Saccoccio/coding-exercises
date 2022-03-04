module ResistorColors
  ( Color(..)
  , value
  ) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Eq, Show, Enum, Bounded)

transform :: Color -> Int
transform Black  = 0
transform Brown  = 1
transform Red    = 2
transform Orange = 3
transform Yellow = 4
transform Green  = 5
transform Blue   = 6
transform Violet = 7
transform Grey   = 8
transform White  = 9

value :: (Color, Color) -> Int
value (a, b) = transform a * 10 + transform b
