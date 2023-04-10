{-# LANGUAGE TypeApplications #-}
-- What is the greatest product of four numbers on the same straight line in the 20 by 20 grid?

import           Control.Arrow
import           Data.Array

adjacent :: [(Int, Int) -> (Int, Int)]
adjacent = [(+ 1) *** id, id *** (+ 1), (+ 1) *** (+ 1), (+ 1) *** (subtract 1)]

products :: Array (Int, Int) Int -> [Int]
products arr =
  let b = bounds arr
   in [product x | i <- range b
                 , dir <- adjacent
                 , let indexes = take 4 (iterate dir i)
                 , all (inRange b) indexes
                 , let x = map (arr !) indexes]

main :: IO ()
main = print . maximum . products . listArray ((1, 1), (20, 20)) . map (read @Int) . words =<< readFile "problem-011.txt"
