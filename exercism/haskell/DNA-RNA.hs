module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA = traverse f
    where
    f 'G' = Right 'C'
    f 'C' = Right 'G'
    f 'T' = Right 'A'
    f 'A' = Right 'U'
    f x = Left x
