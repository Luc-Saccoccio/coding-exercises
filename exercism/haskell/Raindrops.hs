module Raindrops (convert) where

convert :: Int -> String
convert n =
  if null raindrops then show n
                    else raindrops
  where
    raindrops :: String
    raindrops = concatMap f [(3, "Pling"), (5, "Plang"), (7, "Plong")]
    f :: (Int, String) -> String
    f (m, x)
      | n `mod` m == 0 = x
      | otherwise = ""
