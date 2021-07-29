-- Find the sum of all the primes below two million.

primes :: [Int]
primes = 2:[a | a <- [3,5..], notElem 0 $ map (mod a) (takeWhile (<=truncate (sqrt $ fromIntegral a::Float)) primes)]


main :: IO ()
main = print . sum . takeWhile (<= 2000000) $ primes
