module BinarySearch
  ( find
  ) where

import           Data.Array              hiding ( array )

find :: Ord a => Array Int a -> a -> Maybe Int
find array x =
  let (start, end) = bounds array
  in  if start > end then Nothing else go start end (mid start end)
 where
  mid :: Int -> Int -> Int
  mid a b = (a + b) `div` 2
  go :: Int -> Int -> Int -> Maybe Int
  go a b c | a >= b        = if array ! a == x then Just a else Nothing
           | array ! c < x = go (c + 1) b (mid c b)
           | array ! c > x = go a (c - 1) (mid c a)
           | otherwise     = Just c
