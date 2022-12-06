{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow ((&&&))
import           Data.Maybe    (mapMaybe)

divide :: Int -> Int -> Maybe Int
divide x y
  | x `mod` y == 0 = Just $ x `div` y
  | y `mod` x == 0 = Just $ y `div` x
  | otherwise = Nothing

parse :: String -> [[Int]]
parse = map (map (read @Int) . words) . lines

part1 :: String -> Int
part1 = sum . map (uncurry (-) . (maximum &&& minimum)) . parse

part2 :: String -> Int
part2 = sum . map (head . mapMaybe (uncurry divide) . filter (uncurry (>)) . ((<*>) =<< ((,) <$>))) . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
