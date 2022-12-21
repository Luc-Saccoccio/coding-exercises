{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeApplications  #-}

module Main where

import           Control.Arrow        ((&&&))
import           Data.Either          (fromRight)
import           Data.HashMap.Strict  ((!))
import qualified Data.HashMap.Strict  as HM
import qualified Data.Text            as T
import qualified Data.Text.IO         as T
import           Data.Void
import           Text.Megaparsec
import           Text.Megaparsec.Char

data Monkey = Number Int
            | Operation
              { left  :: T.Text
              , op    :: Int -> Int -> Int
              , inv   :: Int -> Int -> Int
              , com   :: Bool
              , right :: T.Text
              }
            | Human

type Monkeys = HM.HashMap T.Text Monkey

type Parser = Parsec Void T.Text

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (x, y, z) = f x y z

parser :: Parser Monkeys
parser = HM.fromList <$> (parseLine `sepEndBy1` eol)
  where
    parseNum :: Parser Int
    parseNum = read @Int <$> some digitChar
    parseOp :: Parser (Int -> Int -> Int, Int -> Int -> Int, Bool)
    parseOp =
      (((*), div, True) <$ char '*')
        <|> (((+), (-), True) <$ char '+')
        <|> ((div, (*), False) <$ char '/')
        <|> (((-), (+), False) <$ char '-')
    parseMonkey :: Parser Monkey
    parseMonkey = (Number <$> parseNum) <|> (uncurry3 <$> (Operation <$> (T.pack <$> some letterChar <* hspace)) <*> parseOp <*> (hspace *> (T.pack <$> some letterChar)))
    parseLine :: Parser (T.Text, Monkey)
    parseLine = (,) <$> ((T.pack <$> some letterChar) <* chunk ": ") <*> parseMonkey

compute :: T.Text -> Monkeys -> (Monkeys, Int)
compute s res =
  case res ! s of
    Number n -> (res, n)
    Operation {..} ->
      let (res', n1) = compute left res
          (res'', n2) = compute right (HM.insert left (Number n1) res')
       in (HM.insert right (Number n2) res'', n1 `op` n2)
    Human -> undefined

isHuman :: Monkeys -> T.Text -> Bool
isHuman monkeys name
  | Number _ <- monkey = False
  | Human <- monkey = True
  | otherwise = any (isHuman monkeys . ($ monkey)) [left, right]
  where
    monkey = monkeys ! name

computeHuman :: T.Text -> Monkeys -> Int -> Int
computeHuman name monkeys target
  | Human <- monkey = target
  | humanLeft       = computeHuman (left monkey) monkeysR targetL
  | otherwise        = computeHuman (right monkey) monkeysL targetR
  where
    monkey = monkeys ! name
    humanLeft = isHuman monkeys (left monkey)
    -- humanRight = isHuman monkeys (right monkey)
    (monkeysL, resL) = compute (left monkey) monkeys
    (monkeysR, resR) = compute (right monkey) monkeys
    targetL = inv monkey target resR
    targetR = if com monkey then inv monkey target resL else op monkey resL target

human :: Monkeys -> Monkeys
human = HM.adjust (\m -> m {op = (-), inv = (+)}) "root" . HM.adjust (const Human) "humn"

part1 :: T.Text -> Int
part1 = snd . compute "root" . fromRight HM.empty . runParser parser "input.txt"

part2 :: T.Text -> Int
part2 = ($ 0) . computeHuman "root" . human . fromRight HM.empty . runParser parser "input.txt"

main :: IO ()
main = T.readFile "input.txt" >>= print . (part1 &&& part2)
