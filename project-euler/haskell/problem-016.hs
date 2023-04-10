-- What is the sum of the digits of the number 2¹⁰⁰⁰ ?

import Data.Char

main :: IO ()
main = print . sum . map digitToInt . show $ 2 ^ 1000
