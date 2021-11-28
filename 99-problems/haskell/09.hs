pack :: Eq a => [a] -> [[a]]
pack [] = []
pack (x:xs) = let (equal, rest) = span (==x) xs
               in (x:equal):pack rest
