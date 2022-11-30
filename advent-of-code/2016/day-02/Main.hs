module Main where

import           Control.Arrow ((&&&))
import           Data.Array
import           Data.List     (foldl', scanl')

type Keypad = Array Int (Array Int Char)

keypad :: Keypad
keypad = listArray (0, 2) $ map (listArray (0, 2)) [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']]

keypadL :: Keypad
keypadL = listArray (0, 4) . map (listArray (0, 4)) $
    [ [' ', ' ', '1', ' ', ' ']
    , [' ', '2', '3', '4', ' ']
    , ['5', '6', '7', '8', '9']
    , [' ', 'A', 'B', 'C', ' ']
    , [' ', ' ', 'D', ' ', ' ']]

coords :: Keypad -> (Int, Int) -> Char
coords k (x, y) = (k ! y) ! x

move :: Keypad -> Int -> (Int, Int) -> Char -> (Int, Int)
move k maxi (x, y) d =
  app $ case d of
    'L' -> (x - 1, y)
    'D' -> (x, y + 1)
    'U' -> (x, y - 1)
    'R' -> (x + 1, y)
    _   -> (x, y)
  where
    -- Not efficient, but Array don't have a "safe access" :/
    app :: (Int, Int) -> (Int, Int)
    app (xn, yn) =
      if (xn >= 0) && (xn < maxi)
         && (yn >= 0) && (yn < maxi)
         && (coords k (xn, yn) /= ' ')
         then (xn, yn) else (x, y)

part1 :: String -> String
part1 = map (coords keypad) . tail . scanl' f (1, 1) . lines
  where
    f :: (Int, Int) -> [Char] -> (Int, Int)
    f = foldl' (move keypad 3)

part2 :: String -> String
part2 = map (coords keypadL) . tail . scanl' f (0, 2) . lines
  where
    f :: (Int, Int) -> [Char] -> (Int, Int)
    f = foldl' (move keypadL 5)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
