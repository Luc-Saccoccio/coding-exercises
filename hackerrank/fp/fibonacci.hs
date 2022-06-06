module Main where


fibs :: [Integer]
fibs = 0 : scanl (+) 1 fibs

constMod :: Integer
constMod = (10 ^ 8) + 7

main = do
    intput <- getLine
    let testCases = (read intput) :: Int
    mapM_ (const $ print . (`mod` constMod) . (fibs!!) . (read :: String -> Int) =<< getLine
          ) [1..testCases]
