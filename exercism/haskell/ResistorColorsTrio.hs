{-# LANGUAGE NumericUnderscores #-}

module ResistorColors
  ( Color(..)
  , Resistor(..)
  , label
  , ohms
  ) where

data Color =
    Black -- 0
  | Brown -- 1
  | Red -- 2
  | Orange -- 3
  | Yellow -- 4
  | Green -- 5
  | Blue -- 6
  | Violet -- 7
  | Grey -- 8
  | White -- 9
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

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

label :: Resistor -> String
label r =
  let value = ohms r
  in  if value >= 1_000_000_000
        then show (value `div` 1_000_000_000) ++ " gigaohms"
        else if value >= 1_000_000
          then show (value `div` 1_000_000) ++ " megaohms"
          else if value >= 1000
            then show (value `div` 1000) ++ " kiloohms"
            else show value ++ " ohms"

ohms :: Resistor -> Int
ohms (Resistor (a, b, c)) =
  (transform a * 10 + transform b) * (10 ^ transform c)
