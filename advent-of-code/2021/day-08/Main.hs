import           Control.Arrow ((&&&))
import           Control.Monad ((<=<))
import           Data.List     (permutations, sort)
import           Data.Map      (Map, fromList, lookup)
import           Data.Maybe    (fromJust, isJust)
import           Prelude       hiding (lookup)

shapes :: Map String Char
shapes = fromList [ ("abcefg", '0')
                  , ("cf", '1')
                  , ("acdeg", '2')
                  , ("acdfg", '3')
                  , ("bcdf", '4')
                  , ("abdfg", '5')
                  , ("abdefg", '6')
                  , ("acf", '7')
                  , ("abcdefg", '8')
                  , ("abcdfg", '9')]

renderSignal :: String -> Maybe Char
renderSignal = flip lookup shapes . sort

mappings :: [Map Char Char]
mappings = map (fromList . zip "abcdefg") (permutations "abcdefg")

solve :: String -> Int
solve = readOutput . choose . flip map mappings . (. ((renderSignal .) . apply)) . flip map . filter ("|" /=) . words
    where
        apply :: Ord a => Map a b -> [a] -> [b]
        apply = map . (fromJust .) . flip lookup

        choose :: [[Maybe a]] -> [a]
        choose = map fromJust . head . filter (all isJust)

        readOutput :: Read a => [Char] -> a
        readOutput = read . reverse . take 4 . reverse

part1 :: String -> Int
part1 = length . filter (flip elem [2, 3, 4, 7] . length) . (drop 11 . words <=< lines)

part2 :: String -> Int
part2 = sum . map solve . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
