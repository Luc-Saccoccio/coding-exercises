module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired = aux [] . filter (`elem` "()[]{}")
  where
    aux :: String -> String -> Bool
    aux c [] = null c
    aux ('(':cs) (')':xs) = aux cs xs
    aux ('[':cs) (']':xs) = aux cs xs
    aux ('{':cs) ('}':xs) = aux cs xs
    aux cs (x:xs)
      | x `elem` "([{" = aux (x:cs) xs
      | otherwise = False
