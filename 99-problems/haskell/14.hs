dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x:x:dupli xs
-- Alternative :
-- dupli = concatMap (replicate 2)
