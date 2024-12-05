{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow   (second, (&&&))
import           Data.Bifunctor  (bimap)
import           Data.List       (sortBy)
import qualified Data.Map.Strict as M
import           Data.Maybe      (fromMaybe)
import qualified Data.Set        as S

type Rules = M.Map Int (S.Set Int)

parse :: String -> (Rules, [[Int]])
parse = bimap (M.fromListWith S.union . map (second S.singleton) . rules) (pages . tail) . break (=="") . lines
  where
    rules :: [String] -> [(Int, Int)]
    rules (x:xs) = ((read @Int) $ take 2 x, (read @Int) $ drop 3 x):rules xs
    rules []     = []
    pages :: [String] -> [[Int]]
    pages (x:xs) = read @[Int] ('[':x ++ "]") : pages xs
    pages []     = []

middle :: [a] -> a
middle xs = xs !! (length xs `div` 2)

keepCorrect :: Rules -> [[Int]] -> [[Int]]
keepCorrect rules updates = filter valid updates
  where
    valid :: [Int] -> Bool
    valid [] = True
    valid [_] = True
    valid (x:y:xs) = y `S.member` fromMaybe S.empty (M.lookup x rules) && valid (y:xs)

correctIncorrect :: Rules -> [[Int]] -> [[Int]]
correctIncorrect rules updates = map (sortBy correctOrder) $ filter (not . valid) updates
  where
    correctOrder :: Int -> Int -> Ordering
    correctOrder x y
      | y `S.member` fromMaybe S.empty (M.lookup x rules) = LT
      | otherwise = GT
    valid :: [Int] -> Bool
    valid [] = True
    valid [_] = True
    valid (x:y:xs) = y `S.member` fromMaybe S.empty (M.lookup x rules) && valid (y:xs)

part1 :: String -> Int
part1 = sum . map middle . uncurry keepCorrect . parse

part2 :: String -> Int
part2 = sum . map middle . uncurry correctIncorrect . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
