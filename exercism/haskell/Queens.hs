module Queens (boardString, canAttack) where

import           Data.List (intersperse)

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines [intersperse ' ' [check i j | j <- [0..7]] | i <- [0..7]]
  where
    check i j
      | Just (i, j) == white = 'W'
      | Just (i, j) == black = 'B'
      | otherwise = '_'

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (x, y) (a, b) =
  (x == a) || (y == b) ||
    abs (x - b) == abs (y - a)
