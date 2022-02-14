module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum [x | x <- [1..(limit-1)], any (divBy x) factors]
    where
        divBy :: Integer -> Integer -> Bool
        divBy _ 0 = False
        divBy x n = x `mod` n == 0
