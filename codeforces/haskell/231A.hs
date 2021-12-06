solution :: String -> String
solution = show . length . filter (>1) . map (length . filter (=="1") . words) . tail . lines

main :: IO ()
main = interact solution
