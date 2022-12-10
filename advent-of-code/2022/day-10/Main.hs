{-# LANGUAGE StrictData       #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import           Control.Arrow ((&&&))

data Instruction = Wait | AddX Int deriving (Show)

parse :: String -> [Instruction]
parse = go . lines
  where
    go :: [String] -> [Instruction]
    go (x : xs) =
      let (ins, n) = span (/= ' ') x
       in if ins == "noop"
            then Wait : go xs
            else Wait : AddX (read @Int n) : go xs
    go [] = []

signal :: Int -> Instruction -> Int
signal n Wait     = n
signal n (AddX x) = n + x

sprite :: [(Int, Int)] -> String
sprite [] = []
sprite ((n, x) : xs) =
  let n' = n `mod` 40
      res = if n' == 39 then '\n' : sprite xs else sprite xs
   in if abs (n' - x) < 2
        then '#' : res
        else '.' : res

part1 :: String -> Int
part1 = sum . multiple [20, 60, 100, 140, 180, 220] . scanl signal 1 . parse
  where
    multiple :: [Int] -> [Int] -> [Int]
    multiple [] _        = []
    multiple (n : ns) xs = n * (xs !! (n - 1)) : multiple ns xs

part2 :: String -> String
part2 = sprite . zip [0 ..] . scanl signal 1 . parse

main :: IO ()
main = readFile "input.txt" >>= (\(x, y) -> print x >> putStrLn y) . (part1 &&& part2)
