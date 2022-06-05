module Luhn (isValid) where

import           Data.Char (digitToInt, isNumber)

isValid :: String -> Bool
isValid n =
  let filtered = filter isNumber n
      res = (sum . map' . reverse $ filtered)
   in res `mod` 10 == 0 && length filtered > 1
  where
    double :: Char -> Int
    double c =
      let i = digitToInt c in
          if i < 5 then 2*i else 2*i - 9
    map' :: [Char] -> [Int]
    map' (x:y:xs) = digitToInt x:double y:map' xs
    map' []       = []
    map' [x]      = [digitToInt x]
