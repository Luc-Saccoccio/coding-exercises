{-# LANGUAGE TypeApplications #-}
module Main where

import           Control.Arrow ((&&&))
import           Data.Char     (chr, ord)
import           Data.List     (foldl', sortBy)
import           Data.Map      (fromListWith, toList)

data Room = Room { name     :: String
                 , sectorID :: Int
                 , checksum :: String } deriving Show

shiftLetter :: Int -> Char -> Char
shiftLetter n c
  | c == '-'  = ' '
  | otherwise = chr $ ord 'a' + (rem (ord c - ord 'a' + n) 26)

letters :: String -> [String]
letters str = map snd . sortBy (flip compare) . toList . fromListWith (++) . map (uncurry (flip (,))) $ toList (fromListWith (+) [([x], 1 :: Int) | x <- str, x /= '-'])

checkChecksum :: Room -> Bool
checkChecksum room = go (letters $ name room) (checksum room)
  where
    go :: [String] -> String -> Bool
    go _ [] = True
    go [] (_:_) = False
    go (x:xs) (c:cs) =
      let (b, str) = consume x c
       in b && (if null str then go xs cs
                            else go (str:xs) cs)

    consume :: String -> Char -> (Bool, String)
    consume [] _ = (False, [])
    consume (x:xs) c
      | c == x = (True, xs)
      | otherwise = (x:) <$> consume xs c

parse :: String -> [Room]
parse = map (toRoom "") . lines
  where
    toRoom :: String -> String -> Room
    toRoom roomName str =
      let (x, xs) = span (/='-') str
       in if null xs then let (i, c) = span (/='[') x
                          in Room { name = roomName, sectorID = read @Int i, checksum = tail $ init c }
                    else toRoom (roomName ++ '-':x) (tail xs)

decipher :: Room -> String
decipher room =
  let n = sectorID room
      roomName = name room
   in map (shiftLetter n) roomName

part1 :: String -> Int
part1 = foldl' f 0 . filter checkChecksum . parse
  where
    f :: Int -> Room -> Int
    f n room = sectorID room + n

part2 :: String -> [(Int, String)]
part2 = map (sectorID &&& decipher) . filter checkChecksum . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
