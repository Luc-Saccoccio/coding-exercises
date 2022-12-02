module Main where

import           Control.Arrow ((&&&))
import           Data.Char

score1 :: Int -> Int -> Int
score1 a b = b + 1 + ((b - a + 1) `mod` 3) * 3

score2 :: Int -> Int -> Int
score2 a b = b * 3 + ((a + b - 1) `mod` 3) + 1

parsePlay :: String -> (Int, Int)
parsePlay (x : _ : z : _) = (ord x - ord 'A', ord z - ord 'X')
parsePlay _               = error "<parsing error>"

part1 :: String -> Int
part1 = sum . map (uncurry score1 . parsePlay) . lines

part2 :: String -> Int
part2 = sum . map (uncurry score2 . parsePlay) . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
