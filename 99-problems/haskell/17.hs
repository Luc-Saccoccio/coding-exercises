split :: [a] -> Int -> ([a], [a])
-- split = flip splitAt
-- split l n = (take nl , drop n l)
split [] _ = ([], [])
split l 0 = ([], l)
split (x:xs) n = let (ys, zs) = split xs (n-1) in (x:ys, zs)
