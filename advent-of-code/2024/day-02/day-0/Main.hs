{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Arrow ((&&&))

parse :: String -> <++>
parse = <++>

part1 :: String -> Int
part1 = const 0

part2 :: String -> Int
part2 = const 1

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
