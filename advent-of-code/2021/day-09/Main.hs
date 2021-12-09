import           Control.Arrow ((&&&))
import           Data.Char     (digitToInt)
import           Data.Graph    (Graph, Tree (..), components, graphFromEdges)
import           Data.List     (sort, zipWith5)
import           Data.Maybe    (catMaybes)

type Coordinate = (Int, Int)

parse :: String -> [[Int]]
parse = (map . map) digitToInt . lines

fst3 :: (a, b, c) -> a
fst3 (x, y, z) = x

-- Filter and transform the list of lists of numbers to a coordinate system
-- While removing all the 9 (can't be mins)
coords :: [[Int]] -> [Coordinate]
coords = catMaybes . concat . zipWith3 (zipWith3 f) (repeat [0..]) (map repeat [0..])
    where
        f _ _ 9 = Nothing
        f x y _ = Just (x, y)

-- Create a graph from the list of coordinates
fromCoordinateList :: [Coordinate] -> Graph
fromCoordinateList coords = fst3 $ graphFromEdges [ ((), (x, y), [(x-1, y), (x+1, y), (x, y-1), (x, y+1)]) | (x, y) <- coords]

minimums :: [[Int]] -> [Int]
minimums grid = catMaybes . concat $
    (zipWith5 . zipWith5) f
    grid
    (map (maxBound :) grid)
    (map ((++ [maxBound]) . tail) grid)
    (repeat maxBound : grid) ((++ [repeat maxBound]) $ tail grid)
    where
        f x l r d u
            | minimum [l, r, d, u] > x = Just x
            | otherwise                = Nothing

size :: Tree a -> Int
size (Node _ children) = succ . sum $ map size children

part1 :: String -> Int
part1 = sum . map succ . minimums . parse

part2 :: String -> Int
part2 = product . take 3 . reverse . sort . map size . components . fromCoordinateList . coords . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
