-- 2, 3 are primes
-- Since we know they are, we only need to check 6k±1
-- This is not the fastest, but it works fine honestly
isPrime :: Integral a => a -> Bool
isPrime n | n < 4 = n > 1
isPrime n = all ((/=0). mod n) $ takeWhile (<=s) (2:3:[x + i | x <- [6,12..], i <- [-1, 1]])
    where s = floor (sqrt (fromIntegral n))
