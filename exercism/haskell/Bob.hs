module Bob
  ( responseFor
  ) where

import           Data.Char                      ( isUpper
                                                , isLetter
                                                , isSpace
                                                )

responseFor :: String -> String
responseFor xs
  | null l = "Fine. Be that way!"
  | last l == '?' = if any isUpper l && all isUpper (filter isLetter l)
    then "Calm down, I know what I'm doing!"
    else "Sure."
  | any isUpper l && all isUpper (filter isLetter l) = "Whoa, chill out!"
  | otherwise = "Whatever."
  where l = filter (not . isSpace) xs
