module Scrabble (scoreLetter, scoreWord) where

import Data.Char (toUpper)

scoreLetter :: Char -> Integer
scoreLetter char
  | c `elem` ("AEIOULNRST"::String) = 1
  | c `elem` ("DG"::String) = 2
  | c `elem` ("BCMP"::String) = 3
  | c `elem` ("FHVWY"::String) = 4
  | c `elem` ("K"::String) = 5
  | c `elem` ("JX"::String) = 8
  | c `elem` ("QZ"::String) = 10
  | otherwise = 0
  where c = toUpper char

scoreWord :: String -> Integer
scoreWord = sum . map scoreLetter
