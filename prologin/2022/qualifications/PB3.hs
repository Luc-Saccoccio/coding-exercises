{-# LANGUAGE TypeApplications #-}

import           Control.Arrow      ((&&&))
import           Control.Monad      (liftM2)
import           Data.IntMap.Strict (IntMap, empty, insertWith, (!?))
import           Data.List          (group)
import           Data.Maybe         (fromJust)
import qualified Data.Set           as Set (Set, foldl, fromList, member,
                                            singleton, filter)

{-
 - Hey, no one's gonna read this piece of shit that is my code
 - So who cares if I'm the only one to understand my comments ¯\_(ツ)_/
-}

{- Definition of structures -}
-- (Start, Finish), both included
type SubList = (Int, Int)
-- Tree Key-(length of list, list)
type DivList = IntMap SubList
-- Set of divisors
type DivSet = Set.Set Int

{- Problem Solution -}
-- Rewritting Show instance is too complex...
showL :: Show a => [a] -> String
showL []     = ""
showL [x]    = show x ++ "\n"
showL (x:xs) = show x ++ " " ++ showL xs

-- Return the difference between the second and the first element. Pointfree style
diff :: SubList -> Int
diff = (+1) . liftM2 (-) snd fst

-- Integer sqrt. Pointfree style
isqrt :: Int -> Int
isqrt = round . (sqrt::Double->Double) . fromIntegral

-- Return the list of the divisors of a number
divisors :: Int -> [Int]
divisors n = (foldr (go . (head &&& length)) [1] . group) $ fac (abs n) 2
    where
        go (_, 0) xs = xs
        go (p, k) xs = let ys = map (* p) xs in go (p, pred k) ys ++ xs
        fac x i
            | x < i * i      = [x | x /= 1]
            | x `mod` i == 0 = i: fac (x `div` i) i
            | otherwise      = fac x $ succ i

-- Return a slice of a list
slice :: Int -> Int -> [a] -> [a]
slice i k xs | i>0 = take (k-i+1) $ drop (i-1) xs
slice _ _ _ = error "Alors non" -- Nope. Won't happen.

-- Return the longest sublist for each divisor, in a map (i.e. dictionnary)
semiValidSubLists :: Int -> DivSet -> [Int] -> DivList
semiValidSubLists n divs l = foldr select empty slices
    where
        -- All possible slices
        slices :: [SubList]
        slices = [(j, i) | i <- [0..n], j <- [1..i]]

        select :: SubList -> DivList -> DivList
        select (start, finish) =
            let s = sum (slice start finish l) in
                if abs s `Set.member` divs then
                    insertWith cmp s (start, finish)
                else
                    id

        -- Compare two sublists and return the longest
        cmp :: SubList -> SubList -> SubList
        cmp l1 l2 =
            let len1 = diff l1
                len2 = diff l2 in
            if len1 > len2 then l1 else l2

-- Return the two best lists
bestLists :: Int -> DivSet -> DivList -> (SubList, SubList)
bestLists n d lists = snd $ Set.foldl select (0, ((0, 0), (0, 0))) divs
    where
        select :: (Int, (SubList, SubList)) -> Int -> (Int, (SubList, SubList))
        select (len, (l1, l2)) divisor =
            case (lists !? divisor, lists !? (n `div` divisor)) of
              (Just l1', Just l2') -> let len' = diff l1' + diff l2'
                                     in if len' > len then (len', (l1', l2')) else (len, (l1, l2))
              _ -> (len, (l1, l2))

        divs :: DivSet
        divs = Set.filter (<=isqrt n) d

-- Return the correct formatted string
formatSolution :: [Int] -> (SubList, SubList) -> String
formatSolution list (s1, s2) =
    let len1 = diff s1
        len2 = diff s2
        list1 = slice' s1
        list2 = slice' s2
    in case compare len1 len2 of -- Order of printing according to lists length
         GT -> showL list1 ++ showL list2
         LT -> showL list2 ++ showL list1
         EQ -> if sum list1 > sum list2 then -- Compute the sums. There is a probably a clever method (storing the value ?)
                    showL list1 ++ showL list2
                else
                    showL list2 ++ showL list1

    where
        -- Pointfree style (inversed argument and accepts a tuple) slice function
        slice' :: SubList -> [Int]
        slice' = flip (uncurry slice) list

-- Solution to the given problem
solution :: String -> String
solution rawInput =
    if x == 0 then
        let div0 = semiValidSubLists n (Set.singleton 0) $ drop 2 input in
            if null div0 then
                "IMPOSSIBLE"
            else
                formatSolution list (fromJust (div0!?0), (0, n))
    else
        let lists = semiValidSubLists n divs list in
            case bestLists x divs lists of
              ((0, 0), (0, 0)) -> "IMPOSSIBLE"
              sub              -> formatSolution list sub

    where
        -- List of number making the input
        input :: [Int]
        input = map (read @Int) . words $ rawInput

        x :: Int
        x = head input

        n :: Int
        n = head $ tail input

        divs :: DivSet
        divs = Set.fromList $ divisors x

        list :: [Int]
        list = drop 2 input

-- Main function, to interact with the world
main :: IO ()
main = interact solution
