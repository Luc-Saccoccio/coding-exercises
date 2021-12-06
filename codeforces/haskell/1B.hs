import Data.List (groupBy)
import Data.Char (chr, ord, isDigit)

switch :: String -> String
switch = convert . groupBy (\a b -> isDigit a == isDigit b)

convert :: [String] -> String
convert [c, r] = "R" ++ r ++ "C" ++ show (toRCcolumn c)
convert [_, r, _, c] = reverse (toXYcolumn (read c)) ++ r
convert _ = error "Impossible"

toRCcolumn :: String -> Int
toRCcolumn = foldl (\s d -> 26*s + ord d - ord 'A' + 1) 0

toXYcolumn :: Int -> String
toXYcolumn 0 = []
toXYcolumn a = chr (ord 'A' + (a - 1) `mod` 26) : toXYcolumn ((a - 1) `div` 26)

solution :: String -> String
solution = unlines . map switch . tail . lines

main :: IO ()
main = interact solution
