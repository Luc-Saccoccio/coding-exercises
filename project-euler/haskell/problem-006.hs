-- Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum

main :: IO ()
main = do
    print $ (sum [1..100])^2 - sum (map (^2) [1..100])
