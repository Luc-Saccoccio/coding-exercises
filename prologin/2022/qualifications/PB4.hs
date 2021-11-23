{-# LANGUAGE TypeApplications #-}

import Control.Monad (replicateM)

-- | Fil reliant deux puces
data Fil = Fil
  { puce1 :: Int  -- ^ première extrémité du fil
  , puce2 :: Int  -- ^ seconde extrémité du fil
  }

-- | Question posée par Joseph
data Question = Question
  { puceA :: Int  -- ^ première extrémité alimentée
  , puceB :: Int  -- ^ seconde extrémité alimentée
  }

-- Affiche le signal envoyé au coffre-fort pour chaque requête
calculerSignaux :: Int -> Int -> Int -> [Int] -> [Fil] -> [Question] -> String
calculerSignaux n m r signaux fils questions = "TODO"

main :: IO ()
main = do
    n <- fmap readInt getLine
    m <- fmap readInt getLine
    r <- fmap readInt getLine
    signaux <- fmap (map readInt . words) getLine
    fils <- replicateM m readFil
    questions <- replicateM r readQuestion
    putStrLn $ calculerSignaux n m r signaux fils questions
    where
        readInt :: String -> Int
        readInt = read @Int
        readFil = fmap ((\[a, b] -> Fil (readInt a) (readInt b)) . words) getLine
        readQuestion = fmap ((\[a, b] -> Question (readInt a) (readInt b)) . words) getLine
