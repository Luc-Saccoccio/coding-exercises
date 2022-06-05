module Triplet (tripletsWithSum) where

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum n = [(a, b, c) | a <- [1..(n-2)], b <- [(a+1)..(n-1)], let c = n - a - b, a^2 + b^2 == c^2]
