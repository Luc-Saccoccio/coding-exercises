-- Evaluate the sum of all the amicable numbers under 10000.

import Data.List

-- From Problem 3
primes :: [Int]
primes = 2 : [a | a <- [3, 5 ..], notElem 0 $ map (mod a) (takeWhile (<= truncate (sqrt $ fromIntegral a :: Float)) primes)]

factors :: Int -> [Int]
factors n = factor n primes
  where
    factor n (p : ps)
      | p * p > n = [n]
      | n `mod` p == 0 = p : factor (n `div` p) (p : ps)
      | otherwise = factor n ps

sumOfDivisors :: Int -> Int
sumOfDivisors n = product [(p * product g - 1) `div` (p - 1) | g <- group $ factors n, let { p = head g }] - n

main :: IO ()
main = print $ sum [n | n <- [2 .. 9999], let m = sumOfDivisors n, let m' = sumOfDivisors m, m > 1, m < 10000, n == m', m' /= sumOfDivisors m']
