{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Arrow ((&&&))
import Data.Bifunctor (bimap)
import Data.List (sort, transpose)

parse :: String -> ([Int], [Int])
parse = (\[x, y] -> (x, y)) . transpose . map (map (read @Int) . words) . lines

part1 :: String -> Int
part1 = sum . map abs . uncurry (zipWith (-)) . bimap sort sort . parse

part2 :: String -> Int
part2 = sum . uncurry (flip (map . flip id)) . bimap (map search . sort) sort . parse
  where
    search _ [] = 0
    search x (y:ys)
      | x < y = 0
      | x == y = x + search x ys
      | otherwise = search x ys

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
