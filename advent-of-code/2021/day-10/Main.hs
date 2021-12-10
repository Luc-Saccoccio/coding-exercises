import Control.Arrow ((&&&))
import Data.List (sort)

middle :: [a] -> a
middle l = l !! (length l `div` 2)

corrupted :: String -> String -> Int
corrupted [] _ = 0
corrupted (')':xs) ('(':acc) = corrupted xs acc
corrupted (']':xs) ('[':acc) = corrupted xs acc
corrupted ('}':xs) ('{':acc) = corrupted xs acc
corrupted ('>':xs) ('<':acc) = corrupted xs acc
corrupted (')':_) _ = 3
corrupted (']':_) _ = 57
corrupted ('}':_) _ = 1197
corrupted ('>':_) _ = 25137
corrupted (x:xs) acc = corrupted xs (x:acc)

close :: Int -> String -> Int
close acc [] = acc
close acc ('(':xs) = close (1 + 5 * acc) xs
close acc ('[':xs) = close (2 + 5 * acc) xs
close acc ('{':xs) = close (3 + 5 * acc) xs
close acc ('<':xs) = close (4 + 5 * acc) xs
close _ _ = error "Impossible"

complete :: String -> String -> Int
complete [] l = close 0 l
complete (')':xs) ('(':ys) = complete xs ys
complete (']':xs) ('[':ys) = complete xs ys
complete ('}':xs) ('{':ys) = complete xs ys
complete ('>':xs) ('<':ys) = complete xs ys
complete (')':_) _ = 0
complete (']':_) _ = 0
complete ('}':_) _ = 0
complete ('>':_) _ = 0
complete (x:xs) ys = complete xs (x:ys)

part1 :: String -> Int
part1 = sum . map (`corrupted` "") . lines

part2 :: String -> Int
part2 = middle . sort . filter (>0) . map (`complete` "") . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
