{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Control.Arrow (first, (&&&))
import Control.Monad ((<$!>))
import Data.Either (fromRight)
import qualified Data.IntMap.Strict as M
import Data.List (nub, sort)
import Data.Text (Text)
import qualified Data.Text.IO as TIO
import Data.Void
import Lens.Micro ((%~), (&), (<<%~), (^.))
import Lens.Micro.TH (makeLenses)
import Text.Megaparsec
import Text.Megaparsec.Char

type Parser a = Parsec Void Text a

data Monkey = Monkey
  { _items :: ![Integer], -- List of items
    _operation :: Integer -> Integer, -- Evolution of worry level
    _divisibleBy :: !Integer,
    _trueMonkey :: !Integer,
    _falseMonkey :: !Integer,
    _inspection :: !Integer -- Number of inspection
  }

makeLenses ''Monkey

type Monkeys = M.IntMap Monkey

parseMonkey :: Parser (Integer, Monkey)
parseMonkey = (,) <$!> monkeyNumber <*> monkey
  where
    monkey :: Parser Monkey
    monkey = Monkey <$!> monkeyItems <*> monkeyOp <*> monkeyDiv <*> monkeyTrue <*> monkeyFalse <*> pure 0
    parseNum :: Parser Integer
    parseNum = (read @Integer) <$!> some digitChar
    monkeyNumber :: Parser Integer
    monkeyNumber = chunk "Monkey " *> parseNum <* char ':' <* newline
    monkeyItems :: Parser [Integer]
    monkeyItems =
      ( space1
          *> chunk "Starting items: "
          *> parseNum
          `sepBy` chunk ", "
      )
        <* newline
    toOp :: Char -> Integer -> Integer -> Integer
    toOp '+' = (+)
    toOp '*' = (*)
    toOp _ = undefined
    toOp' :: Char -> Integer -> Integer
    toOp' '+' = (* 2)
    toOp' '*' = (^ (2 :: Int))
    toOp' _ = undefined
    monkeyOp :: Parser (Integer -> Integer)
    monkeyOp =
      space1
        *> chunk "Operation: new = old "
        *> ( try
               ( toOp
                   <$!> (char '*' <|> char '+')
                   <*> (space1 *> parseNum)
               )
               <|> (toOp' <$!> ((char '*' <|> char '+') <* space1 <* chunk "old"))
           )
    monkeyDiv, monkeyTrue, monkeyFalse :: Parser Integer
    monkeyDiv = space1 *> chunk "Test: divisible by " *> parseNum <* newline
    monkeyTrue = space1 *> chunk "If true: throw to monkey " *> parseNum <* newline
    monkeyFalse = space1 *> chunk "If false: throw to monkey " *> parseNum <* newline

nextMonkey :: Integer -> Monkey -> Integer
nextMonkey n m
  | n `mod` (m ^. divisibleBy) == 0 = m ^. trueMonkey
  | otherwise = m ^. falseMonkey

business :: (Integer -> Integer) -> Monkeys -> Monkeys
business f monkeys = go (M.keys monkeys) monkeys
  where
    go :: [M.Key] -> Monkeys -> Monkeys -- FOLD ?
    go [] !ms = ms
    go (x : xs) !ms =
      go xs $! aux x (ms M.! x) ms
    aux :: M.Key -> Monkey -> Monkeys -> Monkeys
    aux !n !m !ms
      | null (m ^. items) = M.insert n m ms
      | otherwise =
          let (h, m') = first (f . (m ^. operation) . head) $! m & items <<%~ tail
           in aux n (m' & inspection %~ (+ 1)) $! M.adjust (items %~ (h :)) (fromInteger $! nextMonkey h m') ms

nBusiness :: (Integer -> Integer) -> Int -> Monkeys -> Monkeys
nBusiness _ 0 !ms = ms
nBusiness f n !ms = nBusiness f (pred n) (business f ms)

parseMonkeys :: Parser Monkeys
parseMonkeys = M.fromAscList . map (first fromInteger) <$!> some (parseMonkey <* newline)

part1 :: Text -> Integer
part1 = product . take 2 . reverse . sort . map ((^. inspection) . snd) . M.toList . nBusiness (`div` 3) 20 . fromRight M.empty . runParser parseMonkeys "input.txt"

part2 :: Text -> Integer
part2 s = product . take 2 . reverse . sort . map ((^. inspection) . snd) . M.toList . nBusiness f 10000 $! monkeys
  where
    monkeys :: Monkeys
    monkeys = fromRight M.empty $! runParser parseMonkeys "input.txt" s
    f :: Integer -> Integer
    f = (`mod` product (nub $ _divisibleBy . snd <$> M.toList monkeys))

main :: IO ()
main = TIO.readFile "input.txt" >>= print . (part1 &&& part2)
