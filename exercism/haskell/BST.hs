module BST
  ( BST
  , bstLeft
  , bstRight
  , bstValue
  , empty
  , fromList
  , insert
  , singleton
  , toList
  ) where

data BST a = Leaf | Node a (BST a) (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Leaf            = Nothing
bstLeft (Node _ left _) = Just left

bstRight :: BST a -> Maybe (BST a)
bstRight Leaf             = Nothing
bstRight (Node _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Leaf         = Nothing
bstValue (Node v _ _) = Just v

empty :: BST a
empty = Leaf

fromList :: Ord a => [a] -> BST a
fromList = foldl (flip insert) Leaf

insert :: Ord a => a -> BST a -> BST a
insert x Leaf = singleton x
insert x (Node v left right) | x <= v    = Node v (insert x left) right
                             | otherwise = Node v left (insert x right)

singleton :: a -> BST a
singleton x = Node x Leaf Leaf

toList :: BST a -> [a]
toList Leaf         = []
toList (Node v l r) = toList l ++ (v : toList r)
