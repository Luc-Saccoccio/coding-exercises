{-# LANGUAGE StrictData       #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Control.Arrow (first, second, (&&&))
import Data.List (foldl')
import qualified Data.Set as S

type Point = (Int, Int)

type Rope = [Point]

data Move = Move (Point -> Point) Int

type Grid = S.Set Point

parse :: String -> [Move]
parse = map f . lines
  where
    f [] = error "<parsing error>"
    f (x : xs)
      | x == 'L' = Move (first (subtract 1)) (read @Int xs)
      | x == 'D' = Move (second (subtract 1)) (read @Int xs)
      | x == 'U' = Move (second (+ 1)) (read @Int xs)
      | otherwise = Move (first (+ 1)) (read @Int xs)

moves :: [Move] -> Grid -> Rope -> Grid
moves (m : ms) = (uncurry (moves ms) .) . move m
moves [] = const

move :: Move -> Grid -> Rope -> (Grid, Rope)
move (Move f n) s r = foldl' aux (s, r) [1 .. n]
  where
    aux (set, x : xs) _ = moveRope set (f x : xs)
    aux (set, xs) _ = (set, xs)

moveRope :: Grid -> Rope -> (Grid, Rope)
moveRope s [k1, k2] = (S.insert newT s, [k1, newT])
  where
    newT = moveKnot k1 k2
moveRope s (k1 : k2 : ks) = (newS, k1 : newRope)
  where
    newK2 = moveKnot k1 k2
    (newS, newRope) = moveRope s (newK2 : ks)
moveRope s ks = (s, ks)

moveKnot :: Point -> Point -> Point
moveKnot (x, y) (a, b)
  | dx <= 1 && dy <= 1 = (a, b)
  | dx == 2 && dy == 0 = ((x + a) `div` 2, b)
  | dx == 0 && dy == 2 = (a, (y + b) `div` 2)
  | otherwise = (a + if x > a then 1 else (-1), b + if y > b then 1 else (-1))
  where
    dx, dy :: Int
    dx = abs (x - a)
    dy = abs (y - b)

solve :: Int -> String -> Int
solve n s = S.size . moves (parse s) S.empty $! replicate n (0, 0)

part1 :: String -> Int
part1 = solve 2

part2 :: String -> Int
part2 = solve 10

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
