{-# LANGUAGE TypeApplications #-}

import Data.List (sort, group)

f :: [Int] -> String
f (x:y:xs)
  | y>x = show y
  | otherwise = "NO"
f _ = "NO"

solution :: String -> String
solution = f . map head . group . sort . map (read @Int) . tail . words

main :: IO ()
main = interact solution
