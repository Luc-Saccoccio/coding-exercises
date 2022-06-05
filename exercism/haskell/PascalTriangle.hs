module Triangle (rows) where

rowFromPred :: [Integer] -> [Integer]
rowFromPred l = 1 : go l
  where
    go :: [Integer] -> [Integer]
    go (x:y:xs) = (x + y):go (y:xs)
    go [x] = [x]
    go [] = []

rows :: Int -> [[Integer]]
rows n = take n $ iterate rowFromPred [1]
