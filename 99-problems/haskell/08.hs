import Data.List (group)

compress :: Eq a => [a] -> [a]
compress (x:y:xs)
  | x == y = compress (y:xs)
  | otherwise = x:compress (y:xs)
compress l = l

compress' :: Eq a => [a] -> [a]
compress' = map head . group
