import Control.Arrow ((&&&))
import Data.List (foldl', transpose)
import Data.Char (digitToInt)

-- From binary to int
convert :: [Bool] -> Int
convert = foldl' go 0
    where
        go :: Int -> Bool -> Int
        go acc False = acc * 2
        go acc True = acc * 2 + 1

part1 :: String -> Int
part1 = uncurry (*) . (convert &&& (convert . map not)) . map ((>500) . sum . map digitToInt) . transpose . lines

part2 :: String -> Int
part2 _ = uncurry (*) . (oxygen &&& carbon)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
