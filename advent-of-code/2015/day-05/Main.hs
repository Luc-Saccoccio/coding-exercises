module Main
  where

import           Control.Arrow ((&&&))
import           Data.List     (group)

tiles :: String -> [String]
tiles []       = []
tiles [_]      = []
tiles (x:y:xs) = [x, y]:tiles (y:xs)

nice :: String -> Bool
nice s =
  vowels && double && noPattern
    where
      vowels = (>=3) . length $ filter (`elem` "aeiou") s
      double = any ((>=2) . length) $ group s
      noPattern = not . any (`elem` ["ab", "cd", "pq", "xy"]) $ tiles s

part1 :: String -> Int
part1 = length . filter nice . lines

part2 :: String -> String
part2 = const ""

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
