module IsbnVerifier (isbn, indexed) where

import Data.Char (isDigit, digitToInt)
import Control.Monad (liftM2)

indexed :: [a] -> [(Int, a)]
indexed = go 1
  where
    go _ [] = []
    go n (x:xs) = (n, x):go (n+1) xs

isbn :: String -> Bool
isbn l =
  let raw = map translate $ filter (liftM2 (||) isDigit (=='X')) l
   in (length raw == 10) && (elem 0 . fmap (`mod` 11) . foldr f (Just 0) . indexed $ reverse raw)
  where
    translate :: Char -> Int
    translate 'X' = 10
    translate c = digitToInt c

    f :: (Int, Int) -> Maybe Int -> Maybe Int
    f (n, 10)
      | n == 1 = fmap (+10)
      | otherwise = const Nothing
    f (n, x) = fmap (+(n*x))
