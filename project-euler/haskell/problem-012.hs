-- What is the value of the first triangle number to have over five hundred divisors?

import Data.List (group)

-- Taken from Problem 3
primes :: [Int]
primes = 2:[a | a <- [3,5..], notElem 0 $ map (mod a) (takeWhile (<=truncate (sqrt $ fromIntegral a::Float)) primes)]

factors :: Int -> [Int]
factors n = factor n primes
  where
    factor n (p:ps)
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      =     factor n ps

divisorsNumber :: Int -> Int
divisorsNumber = product . map ((+1) . length) . group . factors

main :: IO ()
main = print . head . filter ((> 500) . divisorsNumber) . scanl1 (+) $ [1..]
