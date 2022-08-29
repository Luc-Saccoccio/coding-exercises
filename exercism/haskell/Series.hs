module Series (Error(..), largestProduct) where

import qualified Data.Char as C
import Data.List

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

digitToInt :: Char -> Either Error Integer
digitToInt c
  | C.isDigit c = Right (fromIntegral $ C.digitToInt c)
  | otherwise = Left (InvalidDigit c)

largestProduct :: Int -> String -> Either Error Integer
largestProduct size str
  | size < 0 = Left InvalidSpan
  | length str < size = Left InvalidSpan
  | size == 0 = Right 1
  | otherwise = maximum . map product
                      . foldr (zipWith (:)) (repeat [])
                      . take size . tails <$> traverse digitToInt str
