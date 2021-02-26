-- The prime factors of 13195 are 5, 7, 13 and 29.
-- What is the largest prime factor of the number 600851475143 ?


primes :: [Int]
primes = 2:[a | a <- [3,5..], (all (/= 0) $ map (mod a) (takeWhile (<=truncate (sqrt $ fromIntegral a::Float)) primes))]

factors :: Int -> [Int]
factors n = factor n primes
  where
    factor n (p:ps)
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      =     factor n ps

main :: IO ()
main = do
    print . last $ factors 600851475143
