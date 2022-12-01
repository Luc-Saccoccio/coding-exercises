module School (School, add, empty, grade, sorted) where

import Data.Bifunctor
import Data.List (sort)

type School = [(Int, [String])]

add :: Int -> String -> School -> School
add gradeNum student [] = [(gradeNum, [student])]
add gradeNum student ((n, x) : xs)
  | n == gradeNum = (n, student : x) : xs
  | otherwise = (n, x) : add gradeNum student xs

empty :: School
empty = []

grade :: Int -> School -> [String]
grade = (maybe [] sort .) . lookup

sorted :: School -> [(Int, [String])]
sorted = map (second sort) . sort
