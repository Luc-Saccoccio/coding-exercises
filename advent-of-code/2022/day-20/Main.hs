{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE StrictData #-}
module Main where

import Control.Arrow ((&&&))
import Data.List (foldl')
import Data.Sequence (Seq (..))
import qualified Data.Sequence as S

type CList = Seq (Int, Int)

parse :: String -> [Int]
parse = map (read @Int) . lines

-- Bascially CList but with sequences
focus :: ((Int, Int) -> Bool) -> CList -> CList
focus _ Empty = error "empty list"
focus p cl@(x :<| xs)
  | p x = cl
  | otherwise = focus p (xs :|> x)

focusIndex :: Int -> CList -> CList
focusIndex i = focus ((== i) . fst)

focusValue :: Int -> CList -> CList
focusValue v = focus ((== v) . snd)

move :: CList -> CList
move Empty = error "empty list"
move (x@(_, n) :<| xs) =
  let (ls, rs) = S.splitAt (n `mod` length xs) xs
   in x :<| rs <> ls

mixing :: CList -> CList
mixing cl = foldl' (\acc n -> move $ focusIndex n acc) cl [1..length cl]

indexes :: CList -> [Int]
indexes xs = map (snd . S.index xs . (`mod` length xs)) [1000, 2000, 3000]

part1 :: String -> Int
part1 = sum . indexes . focusValue 0 . mixing . S.fromList . zip [1..] . parse

part2 :: String -> Int
part2 = sum . indexes . focusValue 0 . (!!10) . iterate mixing . S.fromList . zip [1..] . map (*811589153) . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
