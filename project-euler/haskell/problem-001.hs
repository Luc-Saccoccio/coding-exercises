-- If we list all the natural numbers below 10 that are multiples of 3 or 5,
-- we get 3, 5, 6 and 9. The sum of these multiples is 23.
--
-- Find the sum of all the multiples of 3 or 5 below 1000.


import           Data.List (union)

problem_1 :: Int
problem_1 = sum $ union [3,6..999] [5,10..999]

main :: IO ()
main = print problem_1
