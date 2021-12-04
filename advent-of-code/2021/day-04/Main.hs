{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TupleSections #-}

import Control.Arrow ((&&&))
import Data.List (transpose, find)
import Data.List.Split (splitOn)

type Card = [[Int]]
type MarkedCard = [[(Int, Bool)]]

isWinningCard :: MarkedCard -> Bool
isWinningCard card = any (all snd) card || any (all snd) (transpose card)

cardScore :: MarkedCard -> Int
cardScore card = sum $ map (\(x, v) -> if not v then x else 0) $ concat card

markCard :: Int -> MarkedCard -> MarkedCard
markCard draw = map (map (\(x, v) -> (x, v || draw == x)))

parse :: [String] -> ([Int], [Card])
parse (xs:_:ys) = (map read $ splitOn "," xs, cards)
    where cards :: [Card]
          cards =  map (map (map (read @Int) . words)) $ splitOn [""] ys
parse _ = error "Impossible"

playBingo :: [Int] -> [MarkedCard] -> (Int, MarkedCard)
playBingo (x:xs) cards =
    case find isWinningCard markedCards of
      Just card -> (x, card)
      Nothing -> playBingo xs markedCards
    where markedCards = map (markCard x) cards
playBingo _ _ = error "Impossible"

playBingoUntilLastCard :: [Int] -> [MarkedCard] -> (Int, MarkedCard)
playBingoUntilLastCard nums [card] = playBingo nums [card]
playBingoUntilLastCard (x:xs) cards = playBingoUntilLastCard xs filteredCards
    where markedCards = map (map (map (\(num, seen) -> (num, seen || num == x)))) cards
          filteredCards = filter (not. isWinningCard) markedCards
playBingoUntilLastCard _ _ = error "Impossible"

f :: (Int, MarkedCard) -> Int
f (x, c) = x * cardScore c

solve1 :: [Card] -> [Int] -> Int
solve1 cs = f . flip playBingo mcs
    where mcs = (map.map.map) (,False) cs

solve2 :: [Card] -> [Int] -> Int
solve2 cs = f . flip playBingoUntilLastCard mcs
    where mcs = (map.map.map) (,False) cs

part1 :: String -> Int
part1 = uncurry (flip solve1) . parse . lines

part2 :: String -> Int
part2 = uncurry (flip solve2) . parse . lines

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
