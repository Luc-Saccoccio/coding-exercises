module Anagram
  ( anagramsFor
  ) where

import           Data.List                      ( sort )
import           Data.Char                      ( toLower )

anagramsFor :: String -> [String] -> [String]
anagramsFor xs =
  let x = map toLower xs
  in  filter (\a -> let s = map toLower a in s /= x && sort s == sort x)
