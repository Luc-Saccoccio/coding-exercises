module Main where

import Control.Arrow ((&&&), (***))
import Control.Monad (join)
import Data.List (transpose)

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs (x : xs) = ((x,) <$> xs) <> pairs xs

distances :: [(Int, Int)] -> [Int]
distances = map (uncurry distance) . pairs
  where
    distance :: (Int, Int) -> (Int, Int) -> Int
    distance (x, y) (x', y') = abs (x - x') + abs (y - y')

solve :: Int -> String -> Int
solve n = sum . distances . coords . uncurry expand . (transpose *** transpose) . ((,) <*> join expand) . lines
  where
    coords :: [[(Int, (Int, Char))]] -> [(Int, Int)]
    coords rows = [(x, y) | row <- rows, (x, (y, '#')) <- row]
    expand :: [String] -> [[a]] -> [[(Int, a)]]
    expand = ((snd . foldr index (0, [])) .) . zip
    index :: (String, [a]) -> (Int, [[(Int, a)]]) -> (Int, [[(Int, a)]])
    index (x, z) (i, izs) = (if all (== '.') x then i + n else i + 1, map (i,) z : izs)

part1 :: String -> Int
part1 = solve 2

part2 :: String -> Int
part2 = solve 1000000

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
