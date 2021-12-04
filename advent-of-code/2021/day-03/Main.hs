import Control.Arrow ((&&&))
import Data.List (foldl', transpose, group, sort)

-- From binary to int
convert :: [Bool] -> Int
convert = foldl' go 0
    where
        go :: Int -> Bool -> Int
        go acc False = acc * 2
        go acc True = acc * 2 + 1

readB :: String -> [Bool]
readB = map (=='1')

sum' :: [Bool] -> Int
sum' = foldl (\i v -> if v then i + 1 else i) 0

gamma :: [[Bool]] -> [Bool]
gamma = map ((>500) . sum')

binaryFromMatcher :: ([[Bool]] -> [Bool]) -> [[Bool]] -> [Bool]
binaryFromMatcher = getBin 0
    where
        getBin _ _ [x] = x
        getBin pos matcher lst = getBin (pos + 1) matcher $ filterWithMatcher (matcher lst) pos lst
        filterWithMatcher matcher position = filter (\x -> x !! position == matcher !! position)

carbon :: [[Bool]] -> Int
carbon = convert . binaryFromMatcher (map not . gamma)

oxygen :: [[Bool]] -> Int
oxygen = convert . binaryFromMatcher gamma

part1 :: String -> Int
part1 = uncurry (*) . (convert &&& (convert . map not)) . gamma . map readB . transpose . lines

part2 :: String -> Int
part2 = uncurry (*) . (oxygen &&& carbon) . map readB . transpose . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
