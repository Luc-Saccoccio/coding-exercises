module PerfectNumbers
  ( classify
  , Classification(..)
  ) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n | n <= 0       = Nothing
           | n == aliquot = Just Perfect
           | n > aliquot  = Just Deficient
           | otherwise    = Just Abundant
  where aliquot = sum [ d | d <- [1 .. n `div` 2], n `mod` d == 0 ]
