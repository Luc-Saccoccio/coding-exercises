module RunLength (decode, encode) where

import Control.Arrow ((&&&))
import Data.List (group)
import Data.Char (isNumber)

decode :: String -> String
decode "" = ""
decode xs = replicate (if null n then 1 else read n) c ++ decode r
    where
        (n, c:r) = span isNumber xs

encode :: String -> String
encode = concatMap (f . (length &&& head)) . group
    where
        f :: (Int, Char) -> String
        f (x, s) = if x == 1 then [s] else show x ++ [s]
