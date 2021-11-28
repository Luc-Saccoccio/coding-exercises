not' :: Bool -> Bool
not' = not

and' :: Bool -> Bool -> Bool
and' = (&&)

or' :: Bool -> Bool -> Bool
or' = (||)

eq' :: Bool -> Bool -> Bool
eq' = (==)

nor' :: Bool -> Bool -> Bool
nor' = (not' .) . or'

nand' :: Bool -> Bool -> Bool
nand' = (not' .) . and'

xor' :: Bool -> Bool -> Bool
xor' = (not' .) . eq'

-- Is true if a implies b
impl' :: Bool -> Bool -> Bool
impl' = or' . not'

table :: (Bool -> Bool -> Bool) -> IO ()
table f = putStrLn $ unlines [show a ++ ' ' : show b ++ ' ' : show (f a b) | a <- [True, False], b <- [True, False]]
