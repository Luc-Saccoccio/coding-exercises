import Data.List (group)

solution :: String -> String
solution = show . length . group . tail . lines

main :: IO ()
main = interact solution
