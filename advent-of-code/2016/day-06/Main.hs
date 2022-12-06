module Main where

import           Control.Arrow ((&&&))
import           Data.Function (on)
import           Data.List     (group, maximumBy, sort, transpose)

parse :: String -> [String]
parse = transpose . lines

aux :: (Int -> Int -> Ordering) -> String -> String
aux f = map (fst . maximumBy (f `on` snd) . map (head &&& length) . group . sort) . parse

part1 :: String -> String
part1 = aux compare

part2 :: String -> String
part2 = aux (flip compare)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
