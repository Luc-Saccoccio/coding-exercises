-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
-- What is the 10 001st prime number?

primes :: [Int]
primes = 2:[a | a <- [3,5..], (all (/= 0) $ map (mod a) (takeWhile (<=truncate (sqrt $ fromIntegral a::Float)) primes))]

main :: IO ()
main = do
    print (primes !! 10000)
