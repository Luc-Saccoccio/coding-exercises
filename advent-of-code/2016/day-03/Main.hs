{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow ((&&&))
import           Data.List     (foldl', sortBy, transpose)

reverseSort :: Ord a => [a] -> [a]
reverseSort = sortBy (flip compare)

parse :: String -> [[Int]]
parse = map (reverseSort . map (read @Int) . words) . lines

parse2 :: String -> [[Int]]
parse2 = foldl' f [] . transpose . map (map (read @Int) . words) . lines
  where
    f :: [[Int]] -> [Int] -> [[Int]]
    f res []         = res
    f res (x:y:z:xs) = f (reverseSort [x,y,z]:res) xs
    f _ _            = error "<parsing error>"

isTriangle :: [Int] -> Bool
isTriangle []     = False
isTriangle (x:xs) = x < sum xs

part1 :: String -> Int
part1 = length . filter isTriangle . parse

part2 :: String -> Int
part2 = length . filter isTriangle . parse2

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
