module Quadratic where

roots :: Double -> Double -> Double -> Maybe Double
roots a b c
  | (a == 0) || ((b^2) - 4*a*c < 0) = Nothing
  | otherwise = Just (- b / a)
