{-# LANGUAGE TypeApplications #-}
-- Find the maximum total from top to bottom of the triangle below:

{-
  Brute force works for this one. A path search algorithm configured to search the path of maximal cost
  would work in the general case, with better complexity
-}

-- import Control.Monad

main :: IO ()
main = print . head . foldr1 ((<*> tail) . zipWith3 ((. max) . (.) . (+))) . map (map (read @Int) . words) . lines =<< readFile "problem-018.txt"
