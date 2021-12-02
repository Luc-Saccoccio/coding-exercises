import Control.Arrow ((&&&), first, second)
import Data.List (foldl')

data Direction a = Forward a | Down a | Up a

readDirection :: [String] -> Direction Int
readDirection ["forward", x] = Forward (read x::Int)
readDirection ["up", x] = Up (read x::Int)
readDirection ["down", x] = Down (read x::Int)
readDirection _ = error "Impossible"

updatePos :: Direction Int -> (Int, Int) -> (Int, Int)
updatePos (Forward x) = first (x+)
updatePos (Down x) = second (x+)
updatePos (Up x) = second (-x+)

-- (Horizontal Position, Depth, Aim)
updateAim :: Direction Int -> (Int, Int, Int) -> (Int, Int, Int)
updateAim (Down x) (p, d, a) = (p, d, a+x)
updateAim (Up x) (p, d, a) = (p, d, a-x)
updateAim (Forward x) (p, d, a) = (p+x, d + a*x, a)

part1 :: String -> Int
part1 = uncurry (*) . foldl (flip (updatePos . readDirection . words)) (0, 0) . lines

part2 :: String -> Int
part2 = (\(p, d, _) -> p*d) . foldl' (flip (updateAim . readDirection . words)) (0, 0, 0) . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
