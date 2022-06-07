module Diamond (diamond) where

import           Data.Char (chr, ord)

diamond :: Char -> Maybe [String]
diamond c
  | c `elem` ['A'..'Z'] = Just result
  | otherwise = Nothing
  where
    delta = ord c - ord 'A'
    f 0 =
      let spaces = replicate delta ' '
       in spaces ++ "A" ++ spaces
    f k =
      let spaces = replicate (delta - k) ' '
          middle = replicate (2 * k - 1) ' '
          letter = chr (k + ord 'A')
       in spaces ++ [letter] ++ middle ++ [letter] ++ spaces
    result = [f k | k <- [0..delta] ++ [delta - 1, delta - 2..0]]
