module Main where

import           Control.Arrow      (first, second, (&&&))
import qualified Data.Array.Unboxed as A

type Coordinates = (Int, Int)
type Forest = A.UArray Coordinates Char
type Edge = [Char]

parse :: String -> Forest
parse s =
  let xs = lines s
   in A.listArray ((0, 0), (length xs - 1, length (head xs) - 1)) (concat xs)

edges :: Forest -> Coordinates -> [Edge]
edges arr c = map edge [first (+ 1), first (subtract 1), second (+ 1), second (subtract 1)]
  where
    edge :: (Coordinates -> Coordinates) -> Edge
    edge f = [arr A.! i | i <- takeWhile (A.inRange (A.bounds arr)) (iterate f c)]

visible :: [Char] -> Bool
visible (x : xs) = all (< x) xs
visible []       = error "<malformed input>"

isVisible :: Forest -> Coordinates -> Bool
isVisible = (any visible .) . edges

treesVisible :: Edge -> Int
treesVisible [] = error "<malformed input>"
treesVisible (x : xs) =
  case break (>= x) xs of
    (a, []) -> length a
    (a, _)  -> length a + 1

scenicScore :: Forest -> Coordinates -> Int
scenicScore = ((product . map treesVisible) .) . edges

part1 :: String -> Int
part1 xs =
  let arr = parse xs
   in length $ filter (isVisible arr) (A.range (A.bounds arr))

part2 :: String -> Int
part2 xs =
  let arr = parse xs
   in maximum $ map (scenicScore arr) (A.range (A.bounds arr))

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
