len :: [a] -> Int
len = go 0
    where
        go :: Int -> [a] -> Int
        go n [] = n
        go n (_:xs) = go (n+1) xs
