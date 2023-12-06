module Main where

import Control.Arrow ((&&&))

solve :: (Double, Double) -> Int
solve (time, distance) =
  let d = sqrt (time^(2::Int) - 4*distance)
      x1 = (-time + d) / (-2)
      x2 = (time + d) / 2
   in floor x2 - ceiling x1 + 1

part1 :: String -> Int
part1 = product . map solve . uncurry zip . (head &&& last) . map (map read . words . drop 12) . lines

part2 :: String -> Int
part2 = solve . (head &&& last) . map (read . filter (/=' ') . drop 12) . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
