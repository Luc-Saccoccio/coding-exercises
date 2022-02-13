module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, alter, fromList, mapKeys)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = fmap (mapKeys key) . go
 where
  go :: String -> Either String (Map Char Int)
  go [] = Right $ fromList [('A', 0), ('C', 0), ('G', 0), ('T', 0)]
  go (x : xs)
    | x `elem` ['A', 'C', 'G', 'T'] = fmap (alter f x) (go xs)
    | otherwise = Left "error"
  f = fmap (+ 1)
  key :: Char -> Nucleotide
  key 'A' = A
  key 'C' = C
  key 'G' = G
  key _ = T
