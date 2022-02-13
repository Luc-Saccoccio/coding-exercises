module Pangram (isPangram) where

import Data.List (nub)
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram = (==26) . length . nub . filter (`elem` ['a'..'z']) . map toLower
