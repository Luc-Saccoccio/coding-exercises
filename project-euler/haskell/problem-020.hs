-- Find the sum of the digits in the number 100!

import Data.Char (digitToInt)

main :: IO ()
main = print . sum . map digitToInt . show $ product [1..100]
