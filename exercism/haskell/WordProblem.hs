module WordProblem (answer) where

import           Data.Functor       (($>))
import           Text.Parsec
import           Text.Parsec.String

type UnOp = Integer -> Integer
type Op = Integer -> Integer -> Integer

answer :: String -> Maybe Integer
answer = either (const Nothing) Just . parse wordy ""

wordy :: Parser Integer
wordy = string "What is " *> expr <* char '?'

expr :: Parser Integer
expr = foldl (flip ($)) <$> number <*> many (spaces *> (try unOp <|> try raising))

op :: Parser Op
op = choice $ map try
  [ string "plus" $> (+)
  , string "minus" $> (-)
  , string "multiplied by" $> (*)
  , string "divided by" $> div]

unOp :: Parser UnOp
unOp = flip <$> op <*> (space *> number)

number :: Parser Integer
number = do
  sign <- option "" (string "-" <|> string "+")
  absNum <- many1 digit
  pure $ read (sign++absNum)

raising :: Parser UnOp
raising = flip (^) <$>
  (string "raised to the "
    *> number
    <* choice (map try [string "st", string "nd", string "rd", string "th"])
    <* string " power")
