solution :: String -> String
solution = show . minimum . filter (\x -> x `mod` 3 == 0) . map (\x -> read x :: Int) . tail . words

main :: IO ()
main = interact solution
