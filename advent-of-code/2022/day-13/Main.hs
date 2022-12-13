{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow        ((&&&))
import           Data.List            (elemIndex, sort)
import           Data.Maybe           (mapMaybe)
import           Data.Void
import           Text.Megaparsec      (Parsec, between, parseMaybe, sepBy, some,
                                       (<|>))
import           Text.Megaparsec.Char

data Tree = Node [Tree] | Leaf Int deriving Eq
type Parser = Parsec Void String

safeHead :: a -> [a] -> a
safeHead _ (x:_) = x
safeHead x _     = x

(~=) :: [Tree] -> [Tree] -> Ordering
l ~= r =
  let n = length l `compare` length r
   in safeHead n . dropWhile (==EQ) $ zipWith compare l r

instance Ord Tree where
  compare (Leaf a) (Leaf b) = a `compare` b
  compare (Node a) (Leaf b) = a ~= [Leaf b]
  compare (Leaf a) (Node b) = [Leaf a] ~= b
  compare (Node a) (Node b) = a ~= b

parse :: String -> [Tree]
parse = mapMaybe (parseMaybe listParser) . lines
  where
    numParser :: Parser Tree
    numParser = Leaf . read @Int <$> some digitChar
    listParser :: Parser Tree
    listParser = Node <$> between (char '[') (char ']') ((listParser <|> numParser) `sepBy` char ',')

toTuple :: [a] -> [(a, a)]
toTuple (x:y:xs) = (x, y):toTuple xs
toTuple _        = []

part1 :: String -> Int
part1 = sum . map fst . filter snd . zip [1..] . map (uncurry (<)) . toTuple . parse

part2 :: String -> Int
part2 s =
  let lists = parse $ unlines ["[[2]]", "[[6]]", s]
   in product . map succ $ mapMaybe (`elemIndex` sort lists) (take 2 lists)

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
