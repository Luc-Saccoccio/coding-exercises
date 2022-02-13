dropEvery :: [a] -> Int -> [a]
dropEvery l n = go n l
    where
        go :: Int -> [a] -> [a]
        go 1 (_:xs) = go n xs
        go n (x:xs) = x:go (n-1) xs
        go _ [] = []
