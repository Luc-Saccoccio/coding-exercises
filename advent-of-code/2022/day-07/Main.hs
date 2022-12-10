{-# LANGUAGE TypeApplications #-}

module Main where

import           Control.Arrow       ((&&&))
import qualified Data.HashMap.Strict as HM
import           Data.List           (intercalate, isPrefixOf)
import           Data.Maybe          (fromMaybe)
import           Text.Read           (readMaybe)

type FS = HM.HashMap String Int

data Commands = Cd String | Ls [Int]

parse :: String -> [Commands]
parse = go [] . lines
  where
    go [] [] = []
    go l [] = [Ls l]
    go l (x : xs)
      | "$ cd" `isPrefixOf` x =
          let arg = last $ words x
           in if null l
                then Cd arg : go [] xs
                else Ls l : Cd arg : go [] xs
      | x == "$ ls" = go [] xs
      | otherwise =
          let fileSize = takeWhile (/= ' ') x
           in go (maybe l (: l) (readMaybe @Int fileSize)) xs

constructFS :: [Commands] -> FS
constructFS = go HM.empty []
  where
    go :: FS -> [String] -> [Commands] -> FS
    go s path ((Cd x) : xs)
      | x == ".." =
          let currentDir = intercalate "/" path
              outDir = intercalate "/" (tail path)
              s' = HM.insertWith (+) outDir (s HM.! currentDir) s
           in go s' (tail path) xs
      | otherwise =
          let l' = x : path
              currentDir = intercalate "/" l'
              s' = HM.alter (Just . fromMaybe 0) currentDir s
           in go s' l' xs
    go s path ((Ls l) : xs) =
      let currentDir = intercalate "/" path
          s' = HM.insertWith (+) currentDir (sum l) s
       in go s' path xs
    go s l [] = finish s l

    finish :: FS -> [String] -> FS
    finish s [] = s
    finish s path =
      let currentDir = intercalate "/" path
          outDir = intercalate "/" (tail path)
          s' = HM.insertWith (+) outDir (s HM.! currentDir) s
       in finish s' (tail path)

eraseDir :: FS -> Int
eraseDir s = HM.foldr f maxBound s
  where
    unused :: Int
    unused = 70000000 - HM.foldr max 0 s
    f :: Int -> Int -> Int
    f n res = if n + unused >= 30000000 && n < res then n else res

part1 :: String -> Int
part1 = HM.foldr f 0 . constructFS . parse
  where
    f :: Int -> Int -> Int
    f n x = if n <= 100000 then x + n else x

part2 :: String -> Int
part2 = eraseDir . constructFS . parse

main :: IO ()
main = readFile "input.txt" >>= print . (part1 &&& part2)
