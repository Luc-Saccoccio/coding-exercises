myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []
-- Equivalent to
-- myReverse = foldl (\xs x -> x:xs) []
