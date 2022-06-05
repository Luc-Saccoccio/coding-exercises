module DND ( Character(..)
           , ability
           , modifier
           , character
           ) where

import           Control.Monad   (replicateM)
import           Data.List       (sort)
import           Test.QuickCheck (Gen, choose)

data Character = Character
  { strength     :: Int
  , dexterity    :: Int
  , constitution :: Int
  , intelligence :: Int
  , wisdom       :: Int
  , charisma     :: Int
  , hitpoints    :: Int
  }
  deriving (Show, Eq)

charFromList :: [Int] -> Character
charFromList [str, dex, con, int, wis, cha] =
  Character
    { strength = str
    , dexterity = dex
    , constitution = con
    , intelligence = int
    , wisdom = wis
    , charisma = cha
    , hitpoints = 10 + modifier con
    }
charFromList _ = undefined

diceThrow :: Gen Int
diceThrow = choose (1, 6)

ability :: Gen Int
ability = sum . tail . sort <$> replicateM 4 diceThrow

modifier :: Int -> Int
modifier = subtract 5 . (`div` 2)

character :: Gen Character
character = charFromList <$> replicateM 6 ability
