{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow ((&&&))
import           Data.Char     (digitToInt)

parse :: String -> [Int]
parse = map digitToInt . init

aux :: [Int] -> [Int] -> Int
aux [] _ = 0
aux _ [] = 0
aux (x:xs) (y:ys) =
  let res = aux xs ys
   in if x == y then x + res else res

solve :: Int -> String -> Int
solve n = uncurry aux . (id &&& (uncurry (flip (++)) . splitAt n)) . parse

part1 :: String -> Int
part1 = solve 1

part2 :: String -> Int
part2 = solve =<< (`div` 2) . length

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
