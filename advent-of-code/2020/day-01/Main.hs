{-# LANGUAGE TypeApplications #-}

import           Control.Arrow ((&&&))
import           Data.Maybe    (fromJust)

f :: Int -> [Int] -> Maybe Int
f n (x:xs) = if (n - x) `elem` xs then Just (x * (n - x)) else f n xs
f _ []     = Nothing

f' :: [Int] -> Int
f' (x:xs) = case f (2020 - x) xs of
              Nothing -> f' xs
              Just y  -> y*x
f' _ = error "Impossible"

part1 :: String -> Int
part1 = fromJust . f 2020 . map (read @Int) . lines

part2 :: String -> Int
part2 = f' . map (read @Int) . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
