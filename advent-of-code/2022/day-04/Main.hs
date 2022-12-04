{-# LANGUAGE TypeApplications #-}

module Main where

import Control.Arrow (Arrow, second, (&&&), (***))
import Control.Monad (join)
import Data.Set (Set, disjoint, fromDistinctAscList, isSubsetOf, size)

type Range = Set Int

both :: Arrow a => a b c -> a (b, b) (c, c)
both = join (***)

parse :: String -> [(Range, Range)]
parse = map (both (toSet . readRange) . second tail . span (/= ',')) . lines
  where
    readRange :: String -> (Int, Int)
    readRange = both (read @Int) . second tail . span (/= '-')
    toSet :: (Int, Int) -> Range
    toSet = fromDistinctAscList . uncurry enumFromTo

part1 :: String -> Int
part1 = length . filter (uncurry contains) . parse
  where
    contains :: Range -> Range -> Bool
    contains x y
      | size x > size y = y `isSubsetOf` x
      | otherwise = x `isSubsetOf` y

part2 :: String -> Int
part2 = length . filter (uncurry overlap) . parse
  where
    overlap :: Range -> Range -> Bool
    overlap = (not .) . disjoint

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
