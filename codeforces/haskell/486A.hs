{-# LANGUAGE TypeApplications #-}

f :: Int -> Int
f x
  | even x = x`div`2
  | otherwise = -((x`div`2) + 1)


solution :: String -> String
solution = show . f . (read @Int)

main :: IO ()
main = interact solution
