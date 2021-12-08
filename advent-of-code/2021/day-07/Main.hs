{-# LANGUAGE TypeApplications #-}

-- DISCLAIMER : this code is *not* efficient. It works, sure, but it's taking a long time to run

import           Control.Arrow ((&&&))
import           Data.List     (foldl', sort, group)

parse :: String -> [Int]
parse input = read @[Int] $ '[':input++"]"

cost :: (Int -> Int) -> [(Int, Int)] -> Int -> Int
cost f position target = foldl' g 0 position
    where
        g :: Int -> (Int, Int) -> Int
        g c (pos, count) = c + f (abs (target - pos)) * count

align :: (Int -> Int) -> [Int] -> Int
align f initialPosition =
    minimum $ map (cost f (map (head &&& length) . group $ sort initialPosition))
        [0..(maximum initialPosition)]

part1 :: String -> Int
part1 = align id . parse

part2 :: String -> Int
part2 = align (sum . enumFromTo 1) . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
