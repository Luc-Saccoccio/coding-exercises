module Yacht (yacht, Category(..)) where

import           Control.Arrow ((&&&))
import           Data.List     (group, sort)

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

aux :: Int -> [Int] -> Int
aux n = (*n) . length . filter (==n)

groupCount :: Ord a => [a] -> [(Int, a)]
groupCount = map (length &&& head) . group . sort

fullHouse :: [(Int, Int)] -> Int
fullHouse [(n, x), (m, y)]
  | (n, m) `elem` [(2, 3), (3, 2)] = x*n + y*m
  | otherwise = 0
fullHouse _ = 0

fourOfAKind :: [(Int, Int)] -> Int
fourOfAKind [(_, x)] = 4 * x
fourOfAKind [(n, x), (m, y)]
  | n == 1 = 4 * y
  | m == 1 = 4 * x
  | otherwise = 0
fourOfAKind _ = 0

yacht :: Category -> [Int] -> Int
yacht Ones      l = length $ filter (==1) l
yacht Twos      l = aux 2 l
yacht Threes    l = aux 3 l
yacht Fours     l = aux 4 l
yacht Fives     l = aux 5 l
yacht Sixes     l = aux 6 l
yacht FullHouse l = fullHouse $ groupCount l
yacht FourOfAKind l = fourOfAKind $ groupCount l
yacht LittleStraight l =
  if sort l == [1, 2, 3, 4, 5] then 30 else 0
yacht BigStraight l =
  if sort l == [2, 3, 4, 5, 6] then 30 else 0
yacht Choice l = sum l
yacht Yacht l = if length (group l) == 1 then 50 else 0
