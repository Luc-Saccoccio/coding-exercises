module ETL (transform) where

import Data.Map (Map, fromList, toList)
import Data.Char (toLower)

transform :: Map a String -> Map Char a
transform = fromList . concatMap aux . toList
  where
    aux :: (a, String) -> [(Char, a)]
    aux (x, l) = [(toLower c, x) | c <- l]
