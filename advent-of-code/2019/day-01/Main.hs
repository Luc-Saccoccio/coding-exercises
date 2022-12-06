{-# LANGUAGE TypeApplications #-}

module Main where

import           Control.Arrow ((&&&))

parse :: String -> [Int]
parse = map (read @Int) . lines

fuels :: Int -> [Int]
fuels n
  | n > 0 = n : fuels (n`div`3 - 2)
  | otherwise = []

part1 :: String -> Int
part1 = sum . map ((subtract 2) . (`div` 3)) . parse

part2 :: String -> Int
part2 = sum . concatMap (tail . fuels) . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
