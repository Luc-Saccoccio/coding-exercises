{-# LANGUAGE TupleSections #-}
module Befunge93 where

import           Control.Arrow (first, second)
import           Data.Array
import           Data.Char     (chr, ord)
import           Data.List     (uncons)
import           Data.Maybe    (fromMaybe)
import           System.Random (StdGen, uniformR)

type Line    = Array Int Char
type Program = Array Int Line

data Direction = West | South | North | East
  deriving Show
data Pointer = Pointer { pos :: (Int, Int), dir :: Direction, stack :: [Int], output :: [String] }
  deriving Show

defaultPointer :: Pointer
defaultPointer = Pointer (0, 0) East [] []

randomDir :: StdGen -> (Direction, StdGen)
randomDir = first ([West, South, North, East]!!) . uniformR (0, 3)

toArray :: [a] -> Array Int a
toArray = uncurry (listArray . (0,)) . ((,) =<< (subtract 1 . length))

accessArray :: Program -> (Int, Int) -> Char
accessArray arr (a, b) = (arr ! a) ! b

toProgram :: String -> Program
toProgram = toArray . map toArray . lines

arrLength :: Array Int a -> Int
arrLength = (+1) . uncurry subtract . bounds

move :: Program -> Pointer -> Pointer
move arr p =
  let (f, g) =
        case dir p of
          East  -> (id, second $ (`mod` hSize) . (+1))
          West  -> (id, second $ (`mod` hSize) . subtract 1)
          South -> ((`mod` vSize) . (+1), mod')
          North -> ((`mod` vSize) . subtract 1, mod')
   in p { pos = g . first f $ pos p }
  where
    vSize :: Int
    vSize = arrLength arr
    hSize :: Int
    hSize = arrLength (arr ! fst (pos p))
    mod' :: (Int, Int) -> (Int, Int)
    mod' (x, y) = (x, min y . arrLength $ (arr!x))

safe :: (Int -> Int -> Int) -> Int -> Int -> Int
safe _ x 0 = 0
safe f x y = f x y

if' :: a -> a -> Bool -> a
if' x _ True  = x
if' _ y False = y

pop :: [Int] -> (Int, [Int])
pop = fromMaybe (0, []) . uncons

popOp1 :: (Int -> Int) -> [Int] -> [Int]
popOp1 f = uncurry ((:) . f) . pop

-- flipped because b-a and b/a
popOp2 :: (Int -> Int -> Int) -> [Int] -> [Int]
popOp2 f = f' . second pop . pop
  where
    f' :: (Int, (Int, [Int])) -> [Int]
    f' (x, (y, xs)) = f y x:xs

dup :: [Int] -> [Int]
dup [] = [0]
dup (x:xs) = x:x:xs

swap :: [Int] -> [Int]
swap (x:y:xs) = y:x:xs
swap [x] = [0, x]
swap [] = error "Not specified"

travel :: StdGen -> Pointer -> Program -> Pointer
travel g pointer prog = go pointer
  where
    stringMode :: Pointer -> Pointer
    stringMode p =
      case prog `accessArray` pos p of
        '"' -> go (move prog p)
        c   -> stringMode (move prog $ p {stack = ord c:stack p})
    go :: Pointer -> Pointer
    go p =
      case prog `accessArray` pos p of
        '+' -> go (move prog $ p {stack = popOp2 (+)  $ stack p})
        '-' -> go (move prog $ p {stack = popOp2 (-)  $ stack p})
        '*' -> go (move prog $ p {stack = popOp2 (*)  $ stack p})
        '/' -> go (move prog $ p {stack = popOp2 (safe div) $ stack p})
        '%' -> go (move prog $ p {stack = popOp2 (safe mod) $ stack p})
        '!' -> go (move prog $ p {stack = popOp1 (if' 1 0 . (==0)) $ stack p})
        '`' -> go (move prog $ p {stack = popOp2 ((if' 1 0 .) . (>)) $ stack p})
        '>' -> go (move prog $ p {dir = East })
        '<' -> go (move prog $ p {dir = West })
        '^' -> go (move prog $ p {dir = North })
        'v' -> go (move prog $ p {dir = South })
        '?' -> let (d, g') = randomDir g
                in travel g' (move prog $ p {dir = d}) prog
        '_' -> let (v, s) = pop $ stack p
                in go (move prog $ p {stack = s, dir = if' East West (v == 0)})
        '|' -> let (v, s) = pop $ stack p
                in go (move prog $ p {stack = s, dir = if' South North (v == 0)})
        '"' -> stringMode (move prog p)
        ':' -> go (move prog $ p {stack = dup $ stack p})
        '\\' -> go (move prog $ p {stack = swap $ stack p})
        '$' -> go (move prog $ p {stack = snd . pop $ stack p})
        '.' -> let (v, s) = pop $ stack p
                   in go (move prog $ p {stack = s, output =  show v:output p}) -- ord '0' = 48
        ',' -> let (v, s) = pop $ stack p
                   in go (move prog $ p {stack = s, output = [chr v]:output p})
        '#' -> go (move prog . move prog $ p)
        'p' -> let (x, (y, xs)) = second pop . pop $ stack p
                   (v, s) = pop xs
                in travel g (move prog $ p {stack = s}) (prog // [(x, (prog ! x) // [(y, chr v)])])
        'g' -> let (x, (y, xs)) = second pop . pop $ stack p
                   v = if inRange (bounds prog) x && inRange (bounds (prog ! x)) y
                          then ord (prog `accessArray` (x, y))
                          else 0
                in go (move prog $ p {stack = v:xs})

        '@' -> p
        ' ' -> go (move prog p)
        c   -> go (move prog $ p {stack = (ord c - 48):stack p}) -- ASSUMPTION

interpret :: StdGen -> String -> String
interpret g = concat . reverse . output . travel g defaultPointer . toProgram
