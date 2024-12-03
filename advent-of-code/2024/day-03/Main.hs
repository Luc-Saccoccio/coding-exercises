{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Arrow ((&&&))
import Data.Maybe (catMaybes)
import Data.List
import Data.Void
import           Text.Megaparsec (parseMaybe, some, Parsec, chunk)
import           Text.Megaparsec.Char (char, digitChar)

type Parser = Parsec Void String

parseMul :: Parser (Int, Int)
parseMul =
  chunk "mul("
    *> ((,) <$> parseNum <*> (char ',' *> parseNum))
    <* char ')'
  where
    parseNum :: Parser Int
    parseNum = read @Int <$> some digitChar

parse1 :: String -> [Maybe (Int, Int)]
parse1 [] = []
parse1 s
  | isPrefixOf "mul(" s = (parseMaybe parseMul (takeWhile (/=')') s++")")):(parse1 (drop 4 s))
  | otherwise = parse1 (tail s)

parse2 :: Bool -> String -> [Maybe (Int, Int)]
parse2 _ [] = []
parse2 True s
  | isPrefixOf "don't()" s = parse2 False $ drop 7 s
  | isPrefixOf "mul(" s = (parseMaybe parseMul (takeWhile (/=')') s++")")):(parse2 True (drop 4 s))
  | otherwise = parse2 True (tail s)
parse2 False s
  | isPrefixOf "do()" s = parse2 True $ drop 4 s
  | otherwise = parse2 False (tail s)

part1 :: String -> Int
part1 = sum . map (uncurry (*)) . catMaybes . parse1

part2 :: String -> Int
part2 = sum . map (uncurry (*)) . catMaybes . parse2 True

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
