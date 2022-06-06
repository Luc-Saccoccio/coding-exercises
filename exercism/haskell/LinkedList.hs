module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Nil | Cons a (LinkedList a)
  deriving (Show, Eq)

datum :: LinkedList a -> a
datum Nil = undefined
datum (Cons x _) = x

fromList :: [a] -> LinkedList a
fromList [] = Nil
fromList (x:xs) = Cons x (fromList xs)

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

next :: LinkedList a -> LinkedList a
next Nil = Nil
next (Cons _ xs) = xs

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = go Nil
  where
    go acc Nil = acc
    go acc (Cons x xs) = go (Cons x acc) xs

toList :: LinkedList a -> [a]
toList Nil = []
toList (Cons x l) = x:toList l
