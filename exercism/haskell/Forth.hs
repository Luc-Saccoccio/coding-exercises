{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}

module Forth
  ( ForthError(..)
  , ForthState
  , evalText
  , toList
  , emptyState
  ) where

import           Control.Monad    (void)
import           Data.Char        (isSpace)
import           Data.Map.Strict  hiding (toList)
import           Data.Text        (Text, pack, toLower)
import           Prelude          hiding (lookup)
import           Text.Parsec
import           Text.Parsec.Text

data ForthError
     = DivisionByZero
     | StackUnderflow
     | InvalidWord
     | UnknownWord Text
     deriving (Show, Eq)

data Value = Number Int | Word Text | Def Text Stack deriving Show

type Stack = [Value]

type Definitions = Map Text Stack

data ForthState = ForthState Definitions [Int] -- Variables, Stack

emptyState :: ForthState
emptyState = ForthState empty []

evalText :: Text -> ForthState -> Either ForthError ForthState
evalText text state = parseForth text >>= flip eval state

toList :: ForthState -> [Int]
toList (ForthState _ l) = reverse l

-- EVAL

eval :: Stack -> ForthState -> Either ForthError ForthState
eval [] state = Right state
eval (Word x:xs) state@(ForthState defs _) =
  case lookup x defs of
    Nothing -> eval xs =<< evalOp x state
    Just d  -> eval xs =<< eval d state
eval (x:xs) state = eval xs =<< evalValue x state

evalValue :: Value -> ForthState -> Either ForthError ForthState
evalValue (Def w s) (ForthState d st) = Right $ addDef (insert w (substitute s d))
  where
    addDef :: (Definitions -> Definitions) -> ForthState
    addDef f = ForthState (f d) st
evalValue (Number n) (ForthState d st) = Right $ push n
  where
    push :: Int -> ForthState
    push x = ForthState d (x:st)

evalOp :: Text -> ForthState -> Either ForthError ForthState
evalOp "+"    = applyArithmetic (+)
evalOp "-"    = applyArithmetic (-)
evalOp "*"    = applyArithmetic (*)
evalOp "/"    = applyDiv
evalOp "dup"  = apply1 (\x xs -> x : x : xs)
evalOp "drop" = apply1 (\_ xs -> xs)
evalOp "swap" = apply2 (\x y xs -> y : x : xs)
evalOp "over" = apply2 (\x y xs -> y : x : y : xs)
evalOp t      = const . Left $ UnknownWord t

applyArithmetic :: (Int -> Int -> Int) -> ForthState -> Either ForthError ForthState
applyArithmetic f (ForthState defs (x:y:xs)) = Right $ ForthState defs (f y x:xs)
applyArithmetic _ _ = Left StackUnderflow

applyDiv :: ForthState -> Either ForthError ForthState
applyDiv (ForthState _ (0:_:_)) = Left DivisionByZero
applyDiv st                     = applyArithmetic div st

apply1 :: (Int -> [Int] -> [Int]) -> ForthState -> Either ForthError ForthState
apply1 f (ForthState defs (x:xs)) = Right $ ForthState defs (f x xs)
apply1 _ _                        = Left StackUnderflow

apply2 :: (Int -> Int -> [Int] -> [Int]) -> ForthState -> Either ForthError ForthState
apply2 f (ForthState defs (x:y:xs)) = Right $ ForthState defs (f x y xs)
apply2 _ _                          = Left StackUnderflow

substitute :: Stack -> Definitions -> Stack
substitute [] _ = []
substitute (Word x:xs) defs =
  case lookup x defs of
    Nothing -> Word x : substitute xs defs
    Just d  -> d ++ substitute xs defs
substitute (x:xs) defs = x : substitute xs defs

-- OTHER

mapBoth :: (a -> c) -> (b -> d) -> Either a b -> Either c d
mapBoth _ g (Right x) = Right (g x)
mapBoth f _ (Left x)  = Left (f x)

-- PARSING

parseForth :: Text -> Either ForthError Stack
parseForth = mapBoth (const InvalidWord) id . parse ((pure <$> def) <|> stack) ""

number :: Parser Value
number = Number . (read @Int) <$> many1 digit

name :: Parser Text
name = do
  initial <- letter <|> oneOf "+-/*"
  rest <- many (satisfy (not . isSpace))
  pure . toLower . pack $ initial : rest

word :: Parser Value
word = Word <$> name

stack :: Parser Stack
stack = (number <|> word) `sepEndBy1` space

def :: Parser Value
def = do
  char ':' *> spaces
  w <- name <* spaces
  s <- stack
  spaces
  void $ char ';'
  pure (Def w s)
