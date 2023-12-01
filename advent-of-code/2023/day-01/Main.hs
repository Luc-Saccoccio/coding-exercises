{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Arrow ((&&&))
import Data.Char (isDigit)
import Data.List (isPrefixOf, isSuffixOf)

part1 :: String -> Int
part1 = sum . map (f . filter isDigit) . lines
  where
    f :: String -> Int
    f [] = 0
    f xs = 10 * read @Int [head xs] + read @Int [last xs]

part2 :: String -> Int
part2 = sum . map f . lines
  where
    f :: String -> Int
    f [] = 0
    f xs
      | "one" `isPrefixOf` xs = 10 + g xs
      | "two" `isPrefixOf` xs = 20 + g xs
      | "three" `isPrefixOf` xs = 30 + g xs
      | "four" `isPrefixOf` xs = 40 + g xs
      | "five" `isPrefixOf` xs = 50 + g xs
      | "six" `isPrefixOf` xs = 60 + g xs
      | "seven" `isPrefixOf` xs = 70 + g xs
      | "eight" `isPrefixOf` xs = 80 + g xs
      | "nine" `isPrefixOf` xs = 90 + g xs
      | isDigit (head xs) = (10 * read @Int [head xs]) + g xs
      | otherwise = f (tail xs)
    g :: String -> Int
    g [] = 0
    g xs
      | "one" `isSuffixOf` xs = 1
      | "two" `isSuffixOf` xs = 2
      | "three" `isSuffixOf` xs = 3
      | "four" `isSuffixOf` xs = 4
      | "five" `isSuffixOf` xs = 5
      | "six" `isSuffixOf` xs = 6
      | "seven" `isSuffixOf` xs = 7
      | "eight" `isSuffixOf` xs = 8
      | "nine" `isSuffixOf` xs = 9
      | isDigit (last xs) = read @Int [last xs]
      | otherwise = g (init xs)


main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
