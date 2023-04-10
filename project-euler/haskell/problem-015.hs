-- How many such routes are there through a 20×20 grid?

{-
   Since there is 40 steps (20 right and 20 down), it's just choosing which are horizontal and which are vertical :
   / 40 \
   |    |
   \ 20 /
-}

main :: IO ()
main = print $ product [21..40] `div` product [2..20]
