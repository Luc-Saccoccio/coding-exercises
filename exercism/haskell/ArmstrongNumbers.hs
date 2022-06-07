module ArmstrongNumbers (armstrong) where

digits :: Integral a => a -> [a]
digits 0 = []
digits n = n `mod` 10 : digits (n `div` 10)

armstrong :: Integral a => a -> Bool
armstrong num = (==num) $ foldr f 0 dgs
  where
    f :: Integral a => a -> a -> a
    f x = (+x^n)
    dgs = digits num
    n = length dgs
