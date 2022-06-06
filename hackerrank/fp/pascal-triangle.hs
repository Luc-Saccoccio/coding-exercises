module Main where


rowFromPred :: [Integer] -> [Integer]
rowFromPred l = 1 : go l
  where
    go :: [Integer] -> [Integer]
    go [x] = [x]
    go [] = []
    go (x:y:xs) = (x+y):go (y:xs)

rows :: Int -> [[Integer]]
rows n = take n $ iterate rowFromPred [1]

prettyPrint :: [[Integer]] -> IO ()
prettyPrint = mapM_ (\x -> (mapM_ f x) >> putStrLn "")
  where
    f :: Integer -> IO ()
    f n = putStr $ show n ++ " "

main = do
    input <- getLine
    prettyPrint . rows . (read :: String -> Int) $ input
