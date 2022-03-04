module Strain
  ( keep
  , discard
  ) where

discard :: (a -> Bool) -> [a] -> [a]
-- discard p = filter (not . p)
discard _ []       = []
discard p (x : xs) = let ys = discard p xs in if p x then ys else x : ys

keep :: (a -> Bool) -> [a] -> [a]
-- keep = filter
-- keep = discard . not
keep _ []       = []
keep p (x : xs) = let ys = keep p xs in if p x then x : ys else ys
