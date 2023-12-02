{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Arrow   ((&&&))
import qualified Data.Map.Strict as M
import qualified Data.Text       as T
import qualified Data.Text.IO    as TIO

data Cube = Red | Green | Blue deriving (Eq, Ord)

parse :: T.Text -> [[(Int, Cube)]]
parse = map (concatMap (map toCube . T.splitOn ", ") . T.splitOn "; " . T.drop 2 . T.dropWhile (/= ':')) . T.lines
  where
    toCube :: T.Text -> (Int, Cube)
    toCube = (\[x, y] -> (read (T.unpack x), g y)) . T.splitOn " "
    g :: T.Text -> Cube
    g "red"   = Red
    g "green" = Green
    g "blue"  = Blue

valid :: (Int, Cube) -> Bool
valid (n, c)
  | c == Red = n <= 12
  | c == Green = n <= 13
  | c == Blue = n <= 14

power :: [(Int, Cube)] -> Int
power = M.foldr (*) 1 . foldr (uncurry (flip (M.insertWith max))) M.empty

part1 :: T.Text -> Int
part1 = sum . map fst . filter (all valid . snd) . zip [1 ..] . parse

part2 :: T.Text -> Int
part2 = sum . map power . parse

main :: IO ()
main = TIO.readFile "input.txt" >>= print . (part1 &&& part2)
