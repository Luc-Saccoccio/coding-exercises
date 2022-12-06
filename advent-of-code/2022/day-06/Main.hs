module Main where

import           Control.Arrow ((&&&))
import           Witherable    (hashNub)

aux :: Int -> String -> Int
aux n s = go 1 (take n s) s
  where
    go :: Int -> [Char] -> String -> Int
    go i _ [] = i
    go i l (x:xs) =
      let l' = x : init l
       in if length (hashNub l') == n then i else go (i+1) l' xs

part1 :: String -> Int
part1 = aux 4

part2 :: String -> Int
part2 = aux 14

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
