{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TupleSections       #-}

import           Control.Arrow                ((&&&))
import qualified Data.Map                     as M (Map, filter, fromListWith,
                                                    size)
import           Text.ParserCombinators.ReadP (ReadP, char, many1, readP_to_S,
                                               readS_to_P, skipSpaces, string)

type Coordinate = (Int, Int)
type Line = (Coordinate, Coordinate)
type Grid = M.Map Coordinate Int

-- Parse for a single line
parseLine :: ReadP Line
parseLine = do
    (a :: (Int, Int)) <- pair
    skipSpaces
    _ <- string "->"
    skipSpaces
    (b :: (Int, Int)) <- pair
    _ <- char '\n'
    pure (a, b)
    where
        pair = (,) <$> readS_to_P reads <*> (string "," *> readS_to_P reads)

range :: Int -> Int -> [Int]
range x y = [x, (x + signum (y - x))..y]

lineToRange :: Bool ->  Line -> [Coordinate]
lineToRange s ((a, b), (x, y))
  | a /= x && b == y = rangeX (a, b) (x, y)
  | b /= y && a == x = rangeY (a, b) (x, y)
  | otherwise = if s then diag (a, b) (x, y) else []
    where
        rangeX (x0, y0) (x1, _) = [(i, y0) | i <- range x0 x1]
        rangeY (x0, y0) (_, y1) = [(x0, j) | j <- range y0 y1]
        diag   (x0, y0) (x1, y1) = zip (range x0 x1) (range y0 y1)

count :: [Coordinate] -> Grid
count = M.fromListWith (+) . map (, 1)

part1 :: String -> Int
part1 = M.size . M.filter (>1) . count . concatMap (lineToRange False) . fst . last . readP_to_S (many1 parseLine)

part2 :: String -> Int
part2 = M.size . M.filter (>1) . count . concatMap (lineToRange True) . fst . last . readP_to_S (many1 parseLine)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
