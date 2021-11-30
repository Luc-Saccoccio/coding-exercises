import Data.Char (isDigit, isAsciiLower, isAsciiUpper, ord)

-- Return a slice of a list
-- There is a clever way, because taking a slice each time isn't efficient
slice :: Int -> Int -> [a] -> [a]
slice i k xs | i>0 = take (k-i+1) $ drop (i-1) xs
slice _ _ _ = error "Alors non" -- Nope. Won't happen.

isSpecial :: Char -> Bool
isSpecial c = x >= 33 && x <= 47 || x >= 58 && x <= 64 || x >= 91 && x <= 96 || x >= 123 && x <= 126
                where x = ord c

solution :: Int -> Int -> String -> Int
solution n k chaine = length $ filter test slices
    where
        slices :: [String]
        slices = [slice i (i+k-1) chaine | i <- [1..(n-k+1)]]

        test :: String -> Bool
        test c = any isDigit c && any isAsciiLower c && any isAsciiUpper c && any isSpecial c


main :: IO ()
main = do
    n <- fmap read getLine
    k <- fmap read getLine
    chaine <- getLine
    print $ solution n k chaine
