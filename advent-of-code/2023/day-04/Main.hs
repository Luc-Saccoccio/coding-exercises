{-# LANGUAGE TupleSections #-}

module Main where

import Control.Arrow (first, second, (&&&))
import Data.Set (Set, fromList, intersection, size)

both :: (a -> b) -> (a, a) -> (b, b)
both f (x, y) = (f x, f y)

mapN :: Int -> (a -> a) -> [a] -> [a]
mapN 0 _ l = l
mapN _ _ [] = []
mapN n f (x : xs) = f x : mapN (n - 1) f xs

parse :: String -> [(Set Int, Set Int)]
parse = map (both (fromList . map read . words) . second (drop 2) . break (== '|') . drop 2 . dropWhile (/= ':')) . lines

part1 :: String -> Int
part1 = sum . map (power . size . uncurry intersection) . parse
  where
    power :: Int -> Int
    power 0 = 0
    power x = 2 ^ (x - 1)

part2 :: String -> Integer
part2 = go . map ((1,) . uncurry intersection) . parse
  where
    go :: [(Integer, Set Int)] -> Integer
    go [] = 0
    go ((n, s) : xs) = n + go (mapN (size s) (first (+ n)) xs)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
