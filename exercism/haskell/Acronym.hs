module Acronym (abbreviate) where

import Data.Char (toUpper, isUpper)

abbreviate :: String -> String
abbreviate = concatMap (filter isUpper . aux) . words'
    where
        f :: Char -> Bool
        f = (`elem` ['-', ' '])
        aux :: String -> String
        aux [] = []
        aux (x:xs) = if all isUpper (x:xs) then [toUpper x] else toUpper x : xs
        words' :: String -> [String]
        words' s = case dropWhile f s of
                     "" -> []
                     s' -> w:words' s''
                         where
                             (w, s'') = break f s'
