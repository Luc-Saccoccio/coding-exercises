import Control.Arrow ((&&&), first, second)
import Data.List (partition)
import qualified Data.Set as S

f :: Char -> (Int, Int) -> (Int, Int)
f '^' = second (1+)
f 'v' = second (-1+)
f '<' = first (-1+)
f '>' = first (1+)
f _ = id

mapT :: (a -> b) -> (a, a) -> (b, b)
mapT g (a, b) = (g a, g b)

part1 :: String -> S.Set (Int, Int)
part1 = S.fromList . scanl (flip f) (0, 0)

part2 :: String -> Int
part2 = S.size . uncurry S.union . mapT (part1 . map snd) . partition fst . zip (cycle [True, False])

main :: IO ()
main = readFile "input.txt" >>= print . ((S.size . part1) &&& part2)
