{-# LANGUAGE TypeApplications #-}

import           Control.Arrow ((&&&))
import           Data.List     (group, sort)

parse :: String -> [Int]
parse input = read @[Int] $ '[':input++"]"

nextDay :: [Int] -> [Int]
nextDay [a, b, c, d, e, f, g, h, i] = [b, c, d, e, f, g, h + a, i, a]
nextDay _ = error "Impossible"

toSchool :: [Int] -> [Int]
toSchool = map (pred . length) . group . sort . (++ [0..8])

nDay :: Int -> [Int] -> Int
nDay n = sum . (!!n) . iterate nextDay

part1 :: String -> Int
part1 = nDay 80 . toSchool . parse

part2 :: String -> Int
part2 = nDay 256 . toSchool . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
