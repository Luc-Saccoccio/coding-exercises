{-# LANGUAGE TypeApplications #-}

module Main where

import           Control.Arrow      ((&&&))
import           Data.Bifunctor     (bimap)
import           Data.Char          (isNumber, isUpper)
import           Data.IntMap.Strict (IntMap, adjust, fromAscList, toAscList)
import qualified Data.IntMap.Strict as IM ((!))
import           Data.List          (foldl', transpose)

type Stacks = IntMap [Char]

type Instruction = (Int, Int, Int)

parse :: String -> (Stacks, [Instruction])
parse = bimap stacks (map instructions . filter (not . null)) . span (/= "") . lines
  where
    stacks :: [String] -> Stacks
    stacks = fromAscList . zip [1 ..] . filter (\x -> not (null x) && isUpper (head x)) . map (filter (/= ' ')) . transpose . init
    instructions :: String -> Instruction
    instructions = toTuple . map (read @Int) . filter (all isNumber) . words

    toTuple :: [Int] -> Instruction
    toTuple (x : y : z : _) = (x, y, z)
    toTuple xs              = error ("<parsing error> " ++ show xs)

execute :: (String -> String) -> Stacks -> Instruction -> Stacks
execute f s (x, y, z) =
  let l = s IM.! y
      (h, t) = splitAt x l
   in adjust (f h ++) z $ adjust (const t) y s

solve :: (String -> String) -> String -> String
solve f = foldr ((:) . head . snd) [] . toAscList . uncurry (foldl' (execute f)) . parse

part1 :: String -> String
part1 = solve reverse

part2 :: String -> String
part2 = solve id

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
