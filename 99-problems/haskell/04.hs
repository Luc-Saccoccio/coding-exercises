myLength :: [a] -> Int
myLength = foldr (const (+1)) 0
