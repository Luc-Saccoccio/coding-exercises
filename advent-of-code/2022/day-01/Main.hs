{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE LambdaCase #-}
module Main where

import Control.Arrow ((&&&))
import Data.List (groupBy, sortBy)

flipOrder :: Ordering -> Ordering
flipOrder =
  \case
     LT -> GT
     GT -> LT
     EQ -> EQ

parseList :: String -> [Int]
parseList = map (sum . map (read @Int)) . filter (/= [""]) . groupBy (\x y -> y /= "" && x /= "") . lines

part1 :: String -> Int
part1 = maximum . parseList

part2 :: String -> Int
part2 = sum . take 3 . sortBy ((flipOrder .) . compare) . parseList

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
