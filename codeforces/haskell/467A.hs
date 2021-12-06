{-# LANGUAGE TypeApplications #-}

solution :: String -> String
solution = show . length . filter f . map (map (read @Int) . words) . tail . lines
    where
        f :: [Int] -> Bool
        f [x, y] = (y-x)>=2
        f _ = False

main :: IO ()
main = interact solution
