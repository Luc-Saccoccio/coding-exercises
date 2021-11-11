import Data.List (group)
import Control.Arrow ((&&&))

{-
 - TODO : * Finish the go function in bestLists and test first results
 -        * Maybe fusion (And lower complexity) validSums and bestLists
 -          or at least a bit of the functionality in validSums, especially
 -          alreay selecting best lists for each divisors
-}


-- Return the list of the divisors of a number
divisors :: Int -> [Int]
divisors n = (foldr (go . (head &&& length)) [1] . group) $ fac n 2
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

-- Return all the sublists of a list. There is probably a more efficient method
subLists :: Int -> [a] -> [[a]]
subLists n l = [slice j i l | i <- [0..n], j <- [1..i]]

-- Compute all (semi-valid) sums
computeSums :: [[Int]] -> [Int] -> ([Int], [[Int]])
computeSums list divs = go list ([], [])
    where
        go [] sums = sums
        go (x:xs) (sums, valids) =
            let s = sum x in
            if s `elem` divs then
                go xs (s:sums, x:valids)
            else
                go xs (sums, valids)

-- Compute all (valid) sums. Not the smartest way : to enhance
validSums :: Int -> [Int] -> [[Int]] -> ([Int], [[Int]])
validSums x sums lists = go lists sums ([], [])
    where
        go :: [[Int]] -> [Int] -> ([Int], [[Int]]) -> ([Int], [[Int]])
        go [] [] v = v
        go (l:ls) (s:ss) (valids, validl) =
            if (x `div` s) `elem` sums then
                go ls ss (s:valids, l:validl)
            else
                go ls ss (valids, validl)
        go _ _ _ = error "Mais toujours pas en fait"

-- Keeps the bests lists for each couple of divisor
bestLists :: ([Int], [[Int]]) -> [(Int, Int)] -> [([Int], [Int])]
bestLists (sums, lists) = go
    where
        go :: [(Int, Int)] -> [([Int], [Int])] -> [([Int], [Int])]
        go [] [] v = v
        go ((a, b):xs) lists v = v -- TODO

-- Solution to the given problem
solution :: String -> String
solution input = show lists
    where
        list :: [Int]
        list = map (\n -> read n :: Int) . words $ input

        x :: Int
        x = head list

        divs :: [Int]
        divs = divisors x

        nDivs :: Int
        nDivs = length divs

        divsCouples :: [(Int, Int)]
        divsCouples = [(n, x `div` n) | n <- take (nDivs `div` 2) divs]

        lists :: ([Int], [[Int]])
        lists = uncurry (validSums x) $ flip computeSums divs . subLists (list!!1) $ drop 2 list


main :: IO ()
main = interact solution
