module Main where

import           Control.Arrow ((&&&))
import           Data.Char
import           Data.List
import qualified Data.Set      as S

type Half = S.Set Char

priority :: Char -> Int
priority c
  | isUpper c = ord c - 38
  | otherwise = ord c - 96

splitInTwo :: String -> [Half]
splitInTwo list =
  let n = length list `div` 2
   in map S.fromList . (\(x, y) -> [x, y]) $ splitAt n list

takeThree :: [String] -> [[Half]]
takeThree []         = []
takeThree xs =
  let (three, rest) = splitAt 3 xs
   in map S.fromList three :takeThree rest

score :: [Half] -> Int
score = S.foldr' (+) 0 . S.map priority . f
  where
    f []     = S.empty
    f (x:xs) = foldl' S.intersection x xs

part1 :: String -> Int
part1 = sum . map score . map splitInTwo . lines

part2 :: String -> Int
part2 = sum . map score . takeThree . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
