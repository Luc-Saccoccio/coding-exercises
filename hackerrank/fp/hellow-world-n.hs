main :: IO ()
main = do
    n <- getLine
    putStr . unlines . take (read n) $ cycle ["Hello World"]
