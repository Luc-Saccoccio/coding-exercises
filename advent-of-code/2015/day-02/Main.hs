import Data.List (sort)
import Control.Arrow ((&&&))

dims :: String -> (Int, Int, Int)
dims s = (read l::Int, read w::Int, read h::Int) where
    (l, rest)  = span (/= 'x') s
    (w, rest') = span (/= 'x') (tail rest)
    h          = tail rest'

f1 :: (Int, Int, Int) -> Int
f1 (l, w, h) = 2*l*w + 2*w*h + 2*h*l + (product . take 2 $ sort [l, w, h])

f2 :: (Int, Int, Int) -> Int
f2 (l, w, h) = l*w*h + 2*(sum . take 2 $ sort [l, w, h])

part1 :: String -> Int
part1 = sum . map (f1 . dims) . lines

part2 :: String -> Int
part2 = sum . map (f2 . dims) . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
