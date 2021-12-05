{-# LANGUAGE TypeApplications #-}

f :: [Int] -> Int
f = sum . filter odd

-- This part handles the Input/Output and can be used as it is. Do not change or modify it.
main = do
    inputdata <- getContents
    print . f . map (read @Int) $ lines inputdata
