module CustomSet
  ( delete
  , difference
  , empty
  , fromList
  , insert
  , intersection
  , isDisjointFrom
  , isSubsetOf
  , member
  , null
  , size
  , toList
  , union
  ) where

{- I hate size balanced binary trees, but they're efficient, soooooooo.... -}

import           Data.Foldable hiding (minimum, null, toList)
import           Prelude       hiding (minimum, null)

type Size = Int
data CustomSet a = Node !Size !a !(CustomSet a) !(CustomSet a) | Tip deriving (Show)

instance Eq a => Eq (CustomSet a) where
  s1 == s2 = (size s1 == size s2) && (toList s1 == toList s2)

instance Foldable CustomSet where
  fold = aux
    where
      aux Tip            = mempty
      aux (Node 1 x _ _) = x
      aux (Node _ x l r) = aux l `mappend` (x `mappend` aux r)

  foldMap f = aux
    where
      aux Tip            = mempty
      aux (Node 1 x _ _) = f x
      aux (Node _ x l r) = aux l `mappend` (f x `mappend` aux r)


delete :: Ord a => a -> CustomSet a -> CustomSet a
delete _ Tip = Tip
delete x (Node _ y l r)
  | x < y =
    let ll = delete x l in Node (1 + size ll + size r) y ll r
  | x > y =
    let rr = delete x r in Node (1 + size rr + size l) y l rr
  | otherwise =
    let m = minimum r
        rr = delete m r
        deleted
          | null l = r
          | null r = l
          | otherwise = Node (1 + size l + size rr) m l rr
    in deleted

difference :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
difference = foldr delete

empty :: CustomSet a
empty = Tip

fromList :: Ord a => [a] -> CustomSet a
fromList = foldr insert empty

insert :: Ord a => a -> CustomSet a -> CustomSet a
insert x Tip = Node 1 x Tip Tip
insert x set@(Node _ y l r)
  | x == y = set
  | x < y =
    let ll = insert x l in balance $ Node (1 + size ll + size r) y ll r
  | otherwise =
    let rr = insert x r in balance $ Node (1 + size rr + size l) y l rr

intersection :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
intersection set = foldr f empty
  where
    f x s
      | x `member` set = insert x s
      | otherwise = s

isDisjointFrom :: Ord a => CustomSet a -> CustomSet a -> Bool
isDisjointFrom = (null .) . intersection

isSubsetOf :: Ord a => CustomSet a -> CustomSet a -> Bool
isSubsetOf set1 set2 = all (`member` set2) set1

member :: Ord a => a -> CustomSet a -> Bool
member _ Tip = False
member x (Node _ y l r)
  | x == y = True
  | x < y = x `member` l
  | otherwise = x `member` r

null :: CustomSet a -> Bool
null Tip = True
null _   = False

size :: CustomSet a -> Int
size Tip            = 0
size (Node s _ _ _) = s

toList :: CustomSet a -> [a]
toList = foldr (:) []

union :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
union = foldr insert

{- Utility functions -}

minimum :: Ord a => CustomSet a -> a
minimum Tip              = error "Empty CustomSet"
minimum (Node _ x Tip _) = x
minimum (Node _ _ l _)   = minimum l

balL :: Ord a => CustomSet a -> CustomSet a
balL Tip            = Tip
balL (Node s x l r) = Node s x l (balance r)

balR :: Ord a => CustomSet a -> CustomSet a
balR Tip            = Tip
balR (Node s x l r) = Node s x (balance l) r

sizeL :: CustomSet a -> Size
sizeL Tip            = 0
sizeL (Node _ _ l _) = size l

sizeR :: CustomSet a -> Size
sizeR Tip            = 0
sizeR (Node _ _ _ r) = size r

lRotL :: Ord a => CustomSet a -> CustomSet a
lRotL Tip            = Tip
lRotL (Node s x l r) = Node s x (lRot l) r

rRotR :: Ord a => CustomSet a -> CustomSet a
rRotR Tip            = Tip
rRotR (Node s x l r) = Node s x l (rRotR r)

rRot :: Ord a => CustomSet a -> CustomSet a
rRot Tip = Tip
rRot (Node s x l r) = case l of
                        Tip -> Node s x l r
                        (Node _ y ll rr) -> Node s y ll (Node (1 + size rr + size r) x rr r)

lRot :: Ord a => CustomSet a -> CustomSet a
lRot Tip = Tip
lRot (Node s x l r) = case r of
                        Tip -> Node s x l r
                        (Node _ y ll rr) -> Node s y (Node (1 + size ll + size l) x ll l) rr

balance :: Ord a => CustomSet a -> CustomSet a
balance Tip = Tip
balance set@(Node _ _ Tip Tip) = set
balance set@(Node _ _ l r)
  | size l < sizeL r = balance . balR . balL . lRot $ rRotR set
  | size l < sizeR r = balance . balL $ lRot set
  | size r < sizeR l = balance . balR . balL . rRot $ lRotL set
  | size r < sizeL l = balance . balR $ rRot set
  | otherwise = set
