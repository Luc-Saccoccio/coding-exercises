-- Solution from problem 10

import Data.List (group)
import Control.Arrow ((&&&))

encode :: Eq a => [a] -> [(Int, a)]
encode = map (length &&& head) . group

data Item a = Single a | Multiple Int a deriving Show

encodeModified :: [a] -> [Item a]
encodeModified = map aux . encode
    where
        aux :: (Int, a) -> Item a
        aux (1, c) = Single c
        aux (n, c) = Multiple n c
