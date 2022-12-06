module Main where

import Control.Arrow ((&&&))
import Witherable (hashNub)

go :: [Char] -> Int -> String -> Int
go _ n [] = n
go l n (x:xs) =
  let l' = if length l < 4 then (x:l) else x:init l
   in if length (hashNub l') == 4 then n else go l' (n+1) xs

go2 :: [Char] -> Int -> String -> Int
go2 _ n [] = n
go2 l n (x:xs) =
  let l' = if length l < 14 then (x:l) else x:init l
   in if length (hashNub l') == 14 then n else go2 l' (n+1) xs

part1 :: String -> Int
part1 = (+1) . go [] 0

part2 :: String -> Int
part2 = (+1) . go2 [] 0

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
