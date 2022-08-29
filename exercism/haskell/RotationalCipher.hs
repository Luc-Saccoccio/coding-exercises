module RotationalCipher (rotate) where

import           Data.Char (chr, isLower, isUpper, ord, toLower, toUpper)

rotate :: Int -> String -> String
rotate n = map shift
  where
    shift c
      | isUpper c = rot c
      | isLower c = toLower . rot . toUpper $ c
      | otherwise = c
    rot = chr . (\o -> ord 'A' + ((o - ord 'A' + n) `rem` 26)) . ord
