{-# LANGUAGE ViewPatterns #-}

import Data.Array
import Data.Function (on)
import Data.List

next :: Int -> Int
next x
  | even x = x `div` 2
  | otherwise = 3 * x + 1

sequences :: Int -> Array Int Int
sequences n = arr
  where
    arr = listArray (1, n) $ 0:map collatz [2..n]
    collatz (next -> y)
      | y <= n = 1 + arr ! y
      | otherwise = 1 + collatz y

main :: IO ()
main = print . maximumBy (compare `on` snd) . assocs . sequences $ 1000000
