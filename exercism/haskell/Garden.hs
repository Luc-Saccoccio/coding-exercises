module Garden
    ( Plant (..)
    , garden
    , lookupPlants
    ) where

import           Data.List (transpose)

data Plant = Clover
           | Grass
           | Radishes
           | Violets
           deriving (Eq, Show)

type Garden = [(String, [Plant])]

garden :: [String] -> String -> Garden
garden students = fuse students . transpose . lines
  where
    translate :: Char -> Plant
    translate 'C' = Clover
    translate 'G' = Grass
    translate 'R' = Radishes
    translate 'V' = Violets
    translate _   = undefined

    f :: String -> String -> [Plant]
    f x y =
      let g = map translate in concat $ transpose [g x, g y]

    fuse :: [String] -> [String] -> Garden
    fuse (s:ss) (x:y:xs) = (s, f x y):fuse ss xs
    fuse _ _             = []


lookupPlants :: String -> Garden -> [Plant]
lookupPlants student ((s, x):xs)
  | student == s = x
  | otherwise = lookupPlants student xs
lookupPlants _ _ = undefined
