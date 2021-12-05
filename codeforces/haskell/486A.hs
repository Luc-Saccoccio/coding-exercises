{-# LANGUAGE TypeApplications #-}

f :: Int -> Int
f = sum . zipWith (*) (cycle [-1, 1]) . enumFromTo 1

solution :: String -> String
solution = show . f . (read @Int)

main :: IO ()
main = interact solution
