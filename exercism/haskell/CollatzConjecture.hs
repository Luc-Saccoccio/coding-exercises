module CollatzConjecture (collatz) where

collatz' :: Integer -> Integer
collatz' n | n `mod` 2 == 0 = n `div` 2
           | otherwise      = 3 * n + 1

collatz :: Integer -> Maybe Integer
collatz n | n <= 0    = Nothing
  | otherwise = Just . toInteger . length . takeWhile (/= 1) . iterate collatz' $ n
