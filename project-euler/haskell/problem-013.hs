{-# LANGUAGE TypeApplications #-}
-- Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

main :: IO ()
main = putStrLn . take 10 . show . sum . map (read @Integer) . lines =<< readFile "problem-013.txt"
