import           Data.Set        (Set, delete, empty, insert, size)

splitOn :: Eq a => a -> [a] -> [a]
splitOn _ [] = []
splitOn c (x:xs)
  | x == c = xs
  | otherwise = splitOn c xs

solution :: String -> String
solution = show . go empty . lines
    where
        go :: Set String -> [String] -> Int
        go _ []              = 0
        go s (('+':name):xs) = go (insert name s) xs
        go s (('-':name):xs) = go (delete name s) xs
        go s (x:xs) =
            let n = length (splitOn ':' x) in
                (n*size s) + go s xs

main :: IO ()
main = interact solution
