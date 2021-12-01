{-# LANGUAGE TypeApplications #-}

import Control.Arrow ((&&&))

part1 :: String -> Int
part1 = flip go 0 . map (read @Int) . lines
    where
        go :: [Int] -> Int -> Int
        go (x:y:xs) n
          | y > x = go (y:xs) (n + 1)
          | otherwise = go (y:xs) n
        go _ n = n

part2 :: String -> Int
part2 s = go list start 0
    where
        list :: [Int]
        list = map (read @Int) $ lines s

        start :: Int
        start = sum $ take 3 list

        go :: [Int] -> Int -> Int -> Int
        go (x:y:z:xs) p n
          | r > p = go (y:z:xs) r (n+1)
          | otherwise = go (y:z:xs) r n
          where r = x+y+z
        go _ _ n = n

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
