{-# LANGUAGE TypeApplications #-}

f :: [Int] -> [Int]
f = map abs

main :: IO ()
main = do
    inputdata <- getContents
    mapM_ print . f . map (read @Int) $ lines inputdata
