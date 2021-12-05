f :: [Int] -> [Int]
f xs = [x | (x, i) <- zip xs [0..], odd i]

-- This part deals with the Input and Output and can be used as it is. Do not modify it.
main :: IO ()
main = do
    inputdata <- getContents
    mapM_ print . f . map read . lines $ inputdata
