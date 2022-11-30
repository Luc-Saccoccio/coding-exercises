{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}

module Main where

import           Control.Arrow ((&&&))
import           Data.List     (foldl')
import qualified Data.Set      as S
import qualified Data.Text     as T (Text, head, splitOn, tail, unpack)
import qualified Data.Text.IO  as T (readFile)

data Direction = W | N | E | S
type Path = S.Set (Int, Int)
data Me = Me
  { position  :: (Int, Int)
  , direction :: Direction
  , path      :: Path }

meStart :: Me
meStart = Me { position = (0, 0), direction = N, path = S.empty }

rotate :: Char -> Me -> Me
rotate x me
  | x == 'L'  = me { direction = rL d }
  | otherwise = me { direction = rR d }
    where
      d = direction me
      rR = \case
              W -> N
              N -> E
              E -> S
              S -> W
      rL = \case
              N -> W
              E -> N
              S -> E
              W -> S

step :: Int -> Me -> Me
step n me = let (x, y) = position me in
  case direction me of
    N -> me { position = (x+n, y) }
    S -> me { position = (x-n, y) }
    E -> me { position = (x, y+n) }
    W -> me { position = (x, y-n) }

stepPath :: Int -> Me -> (Maybe (Int, Int), Me)
stepPath 0 me = (Nothing, me)
stepPath n me =
  let me' = step 1 me
      newPos = position me'
   in if newPos `S.member` path me
         then (Just newPos, me')
         else stepPath (n-1) $ me' { path = S.insert newPos (path me) }

followPath :: T.Text -> Me
followPath = foldl' go meStart . T.splitOn ", "
  where
    go :: Me -> T.Text -> Me
    go me x =
      let d = T.head x
          n = read @Int . T.unpack $ T.tail x
       in step n $ rotate d me

rememberPath :: T.Text -> Me
rememberPath = go meStart . T.splitOn ", "
  where
    go :: Me -> [T.Text] -> Me
    go me [] = me
    go me (x:xs) =
      let d = T.head x
          n = read @Int . T.unpack $ T.tail x
          (found, me') = stepPath n $ rotate d me
       in maybe (go me' xs) (const me') found

dist :: (Int, Int) -> Int
dist (x, y) = abs x + abs y

part1 :: T.Text -> Int
part1 = dist . position . followPath

part2 :: T.Text -> Int
part2 = dist . position . rememberPath

main :: IO ()
main = T.readFile "input.txt" >>= print . (part1 &&& part2)
