{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Arrow (first, (&&&), (***))
import Data.List (uncons)
import Data.Maybe (fromJust)
import Data.Text qualified as T
import Data.Text.IO qualified as TIO

type Map = [(Int, Int, Int)]

type Maps = [Map]

parse :: T.Text -> ([Int], Maps)
parse = (seeds *** maps) . fromJust . uncons . T.splitOn "\n\n"
  where
    seeds :: T.Text -> [Int]
    seeds = map (read . T.unpack) . tail . T.words
    maps :: [T.Text] -> Maps
    maps = map (map (toTuple . map (read . T.unpack) . T.words) . tail . T.lines)
    toTuple :: [Int] -> (Int, Int, Int)
    toTuple ~(x : y : z : _) = (x, y, z)

toIntervals :: [Int] -> [(Int, Int)]
toIntervals [] = []
toIntervals ~(x : y : xs) = (x, x + y - 1) : toIntervals xs

mapInRange :: Map -> Int -> Int
mapInRange [] n = n
mapInRange ((y, x, o) : xs) n
  | n >= x && n <= (x + o) = y + (n - x)
  | otherwise = mapInRange xs n

evolve :: [Int] -> Maps -> [Int]
evolve = foldl (flip $ map . mapInRange)

mapRangeInRange :: Map -> (Int, Int) -> [(Int, Int)]
mapRangeInRange [] n = [n]
mapRangeInRange ((y, x, o) : xs) (ns, ne)
  | destE < ns || ne < x = mapRangeInRange xs (ns, ne)
  | x <= ns && ne <= destE = [(ns + d, ne + d)]
  | x <= ns && destE < ne = (ns + d, destE + d) : mapRangeInRange xs (destE + 1, ne)
  | ns < x && ne <= destE = (x + d, ne + d) : mapRangeInRange xs (ns, x - 1)
  | ns < x && destE < ne = (x + d, destE + d) : (mapRangeInRange xs (ns, x - 1) ++ mapRangeInRange xs (destE + 1, ne))
  where
    d, destE :: Int
    d = y - x
    destE = x + o - 1

evolveRange :: [(Int, Int)] -> Maps -> [(Int, Int)]
evolveRange = foldl (flip $ concatMap . mapRangeInRange)

part1 :: T.Text -> Int
part1 = minimum . uncurry evolve . parse

part2 :: T.Text -> Int
part2 = fst . minimum . uncurry evolveRange . first toIntervals . parse

main :: IO ()
main = TIO.readFile "input.txt" >>= print . (part1 &&& part2)
