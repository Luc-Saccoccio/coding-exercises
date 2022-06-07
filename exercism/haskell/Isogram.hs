module Isogram (isIsogram) where

import Data.List (nub)
import Data.Char (isLetter, toLower)
-- import Control.Arrow ((&&&))

isIsogram :: String -> Bool
isIsogram s =
  let filtered = map toLower $ filter isLetter s
      cleaned = nub filtered
   in length cleaned == length filtered

-- Fancy & useless version
-- isIsogram = uncurry (==) . ((length . map toLower . filter isLetter) &&& (length . nub . map toLower . filter isLetter))
