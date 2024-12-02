{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Monad (liftM2)
import Control.Arrow ((&&&))
import Data.List (inits, tails)

parse :: String -> [[Int]]
parse = map (map (read @Int) . words) . lines

sup, inf :: Int -> Bool
sup = liftM2 (&&) (< 4) (> 0)
inf = liftM2 (&&) (< 0) (> -4)

sane :: [Int] -> Bool
sane xs = liftM2 (||) (all sup) (all inf) . zipWith (-) xs $ tail xs

part1 :: String -> Int
part1 = length . filter sane . parse

part2 :: String -> Int
part2 = length . filter f . parse
  where
    f :: [Int] -> Bool
    f xs =
      let p = xs : zipWith (++) (inits xs) (drop 1 $ tails xs)
       in any sane p

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
