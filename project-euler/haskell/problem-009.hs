-- There exists exactly one Pythagorean triplet for which a + b + c = 1000.
-- Find the product abc.

triplets l = [(a, b, c) | m <- [2..limit], n <- [1..(m-1)], 
                          let a = m^2 - n^2,
                          let b = 2*m*n,
                          let c = m^2 + n^2,
                          a+b+c == l]
    where limit = floor . sqrt . fromIntegral $ l

main :: IO ()
main = print $ (\(a, b, c) -> a*b*c) . head . triplets $ 1000
