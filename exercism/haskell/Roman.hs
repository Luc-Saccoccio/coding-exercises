module Roman (numerals) where

numerals :: Integer -> Maybe String
numerals n
  | n >= 1000 = ('M':) <$> numerals (n-1000)
  | n >= 900  = ('C':) . ('M':) <$> numerals (n - 900)
  | n >= 500  = ('D':) <$> numerals (n - 500)
  | n >= 400  = ('C':) . ('D':) <$> numerals (n-400)
  | n >= 100  = ('C':) <$> numerals (n-100)
  | n >= 90   = ('X':) . ('C':) <$> numerals (n - 90)
  | n >= 50   = ('L':) <$> numerals (n - 50)
  | n >= 40   = ('X':) . ('L':) <$> numerals (n - 40)
  | n >= 10   = ('X':) <$> numerals (n - 10)
  | n == 9    = Just "IX"
  | n >= 5    = ('V':) <$> numerals (n - 5)
  | n == 4    = Just "IV"
  | n >= 1    = ('I':) <$> numerals (n - 1)
  | n == 0    = Just ""
  | otherwise = Nothing
