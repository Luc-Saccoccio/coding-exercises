module Main where

mingle :: String -> String -> String
mingle [] [] = []
mingle (x:xs) (y:ys) = x:y:mingle xs ys
mingle _ _ = undefined

main :: IO ()
main = do
  string1 <- getLine
  string2 <- getLine
  putStrLn (mingle string1 string2)
