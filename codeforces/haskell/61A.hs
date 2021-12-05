xor :: String -> String -> String
xor _ [] = []
xor [] _ = []
xor (x:xs) (y:ys)
  | x /= y = '1':xor xs ys
  | otherwise = '0':xor xs ys

main :: IO ()
main = do
    a <- getLine
    b <- getLine
    putStrLn $ xor a b
