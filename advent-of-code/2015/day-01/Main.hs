import Control.Arrow ((&&&))

part1 :: String -> Int
part1 = sum . map value
    where
        value :: Char -> Int
        value '(' = 1
        value ')' = -1
        value _ = 0

part2 :: Int -> Int -> String -> Int
part2 (-1) p _ = p
part2 n p ('(':xs) = part2 (n+1) (p+1) xs
part2 n p (')':xs) = part2 (n-1) (p+1) xs
part2 n p (_:xs) = part2 n p xs
part2 _ _ _ = error "Impossible"

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2 0 0)
