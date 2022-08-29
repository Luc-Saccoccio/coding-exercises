module Sgf (parseSgf) where

import           Control.Monad    (void)
import           Data.Map         (Map, fromList)
import           Data.Text        (Text, pack)
import           Data.Tree        (Tree (..))
import           Text.Parsec
import           Text.Parsec.Text (Parser)

-- | A tree of nodes.
type SgfTree = Tree SgfNode

-- | A node is a property list, each key can only occur once.
-- Keys may have multiple values associated with them.
type SgfNode = Map Text [Text]

parseSgf :: Text -> Maybe (Tree (Map Text [Text]))
parseSgf = either (const Nothing) Just . parse bigTree ""

wholeTree :: Parser SgfTree
wholeTree = smolTree <|> bigTree

bigTree :: Parser SgfTree
bigTree = between (char '(') (char ')') smolTree

smolTree :: Parser SgfTree
smolTree = do
  void $ char ';'
  node <- many keyVal
  forest <- many wholeTree
  return $ Node (fromList node) forest

keyVal :: Parser (Text, [Text])
keyVal = (,) <$> key <*> many1 (between (char '[') (char ']') value)

key :: Parser Text
key = pack <$> many1 upper

value :: Parser Text
value = pack . filter (/='\n') <$> many1 (choice [' ' <$ space, char '\\' *> anyChar, noneOf "[]"])
