{-# LANGUAGE TypeApplications #-}

import           Control.Arrow    ((&&&))
import           Control.Monad    (liftM2)
import           Data.IntMap.Lazy (IntMap, empty, filterWithKey, insertWith,
                                   keys, member, (!))
import           Data.List        (group)

{-
 - TODO : * Maybe fusion bestLists and validSums to do one less tree traversal
 -        Idea : to reduce divisor checking use a Hashtable
 - TODO : There must be a smarter way to find good sublists. It's taking too much time
 -
 - Hey, no one's gonna read this piece of shit that is my code
 - So who cares if I'm the only one to understand my comments ¯\_(ツ)_/
-}

{- Definition of structures -}
-- (Start, Finish), both included
type SubList = (Int, Int)
-- Tree Key-(length of list, list)
type DivList = IntMap SubList

{- Problem Solution -}
-- Rewritting Show instance is too complex...
showL :: Show a => [a] -> String
showL []     = ""
showL [x]    = show x
showL (x:xs) = show x ++ " " ++ showL xs

-- Return the difference between the second and the first element
diff :: SubList -> Int
diff = (+1) . liftM2 (-) snd fst

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
slice _ _ _ = error "Alors non"

-- Return the longest sublist for each divisor, in a map (i.e. dictionnary)
semiValidSubLists :: Int -> [Int] -> [Int] -> DivList
semiValidSubLists n divs l = go slices
    where
        slices :: [SubList]
        slices = [(j, i) | i <- [0..n], j <- [1..i]]

        go :: [SubList] -> DivList
        go []     = empty
        go ((start, finish):xs) =
            let s = sum (slice start finish l) in
                if abs s `elem` divs then
                    insertWith cmp s (start, finish) $ go xs
                else
                    go xs

        -- O(n+m) : computes both length -> to enhance
        cmp :: SubList -> SubList -> SubList
        cmp (sA, fA) (sB, fB) =
            let lenA = fA - sA + 1
                lenB = fB - sB + 1 in
            if lenA > lenB then (sA, fA) else (sB, fB)

-- Remove all invalid list
validSums :: Int -> DivList -> DivList
validSums n lists = filterWithKey cmp lists
    where
        cmp :: Int -> a -> Bool
        cmp k _ = (n `div` k) `member` lists

-- Returns the two best lists (by maximum sum of length)
bestLists :: Int -> DivList -> (SubList, SubList)
bestLists n l = go divs 0 ((0, 0), (0, 0))
    where
        go :: [Int] -> Int -> (SubList, SubList) -> (SubList, SubList)
        go [] _ v = v
        go (x:xs) len (list1, list2) =
            let l1 = l!x
                l2 = l!(n`div`x)
                len' = diff l1 + diff l2 in
            if len' > len then go xs len' (l1, l2)
            else go xs len (list1, list2)

        divs :: [Int]
        divs = aux (keys l) []

        aux :: [Int] -> [Int] -> [Int] -- List of individual divisors without their "complement"
        aux [] v     = v
        aux (x:xs) v = if x `div` n `elem` v then aux xs v else aux xs (x:v)

formatSolution :: [Int] -> (SubList, SubList) -> String
formatSolution list (s1, s2) =
    let len1 = diff s1
        len2 = diff s2
        list1 = slice' s1
        list2 = slice' s2
    in if len1 > len2 then
        showL list1 ++ "\n" ++ showL list2
    else if len1 < len2 then
        showL list2 ++ "\n" ++ showL list1
    else
        if sum list1 > sum list2 then
            showL list1 ++ "\n" ++ showL list2
        else
            showL list2 ++ "\n" ++ showL list1

    where
        slice' :: SubList -> [Int]
        slice' = flip (uncurry slice) list

-- Solution to the given problem
solution :: String -> String
solution rawInput =
    if x == 0 then
        let div0 = semiValidSubLists n [0] $ drop 2 input in
            if null div0 then
                "IMPOSSIBLE"
            else
                formatSolution list (div0!0, (0, n))
    else
        let lists = semiValidSubLists n divs list in
        if null lists then
            "IMPOSSIBLE"
        else
            formatSolution list . bestLists x $ validSums x lists
    where
        input :: [Int]
        input = map (read @Int) . words $ rawInput

        x :: Int
        x = head input

        n :: Int
        n = head $ tail input

        divs :: [Int]
        divs = divisors x

        list :: [Int]
        list = drop 2 input

-- Main function, to interact with the world
main :: IO ()
main = interact solution
