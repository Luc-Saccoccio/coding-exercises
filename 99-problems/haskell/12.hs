data Item a = Single a | Multiple Int a deriving Show

decodeModified :: [Item a] -> [a]
decodeModified [] = []
decodeModified ((Single x):xs) = x:encodeDirect xs
decodeModified ((Multiple 2 x):xs) = x:x:encodeDirect xs
decodeModified ((Multiple n x):xs) = x:encodeDirect (Multiple (n-1) x):xs
