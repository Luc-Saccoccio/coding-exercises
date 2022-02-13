repli :: [a] -> Int -> [a]
repli l n = concatMap (replicate n) l
