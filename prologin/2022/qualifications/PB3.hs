import           Control.Arrow    ((&&&))
import           Data.IntMap.Lazy (IntMap, delete, empty, insertWith, keys,
                                   member)
import           Data.List        (group)

{-
 - TODO : * Treat the case where X = 0 !
-}

type DivList = IntMap [Int]

del :: Eq a => a -> [a] -> Maybe [a]
del _ []     = Nothing
del n (x:xs) = if x == n then Just xs else (x:) <$> del n xs

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
        slices :: [[Int]]
        slices = [slice j i l | i <- [0..n], j <- [1..i]]

        -- insertWith : O(min(n, W)), n being number of entries in tree and W number of bits in Int
        go :: [[Int]] -> DivList
        go []     = empty
        go (x:xs) =
            let s = sum x in
                if abs s `elem` divs then
                    insertWith cmp s x $ go xs
                else
                    go xs

        -- O(n+m) : computes both length -> to enhance
        cmp :: [Int] -> [Int] -> [Int]
        cmp a b = if length a > length b then a else b

-- Remove all invalid list
-- TODO : not able to spot (-x)(-y) = xy !
-- TODO : in fact this functions doesn't work ._.
validSums :: Int -> [Int] -> DivList -> DivList
validSums n divs lists = go divs []
    where
        go :: [Int] -> [Int] -> DivList
        go [] _ = lists
        go (x:xs) done =
            let m = x `div` n in
            case del x done of
               Just l -> go xs l -- The job is already done bois
               Nothing ->
                    if member m lists then
                        go xs (m:done) -- divs is constructed without duplicates, so no need to add x
                    else
                        delete m $ go xs done -- No need to add it to done, it won't appear

-- TODO Returns the two best lists (by maximum sum of length)
bestLists :: DivList -> ([Int], [Int])
bestLists l = ([], [])

-- TODO Solution to the given problem
solution :: String -> String
solution rawInput = show lists
    where
        input :: [Int]
        input = map (\n -> read n :: Int) . words $ rawInput

        x :: Int
        x = head input

        divs :: [Int]
        divs = divisors x

        lists :: DivList
        lists = uncurry (validSums x) . (keys &&& id) . semiValidSubLists x divs $ drop 2 input -- See if it's possible to <not> use keys (O(n)) but calculate it in semiValidSubLists


main :: IO ()
main = interact solution
