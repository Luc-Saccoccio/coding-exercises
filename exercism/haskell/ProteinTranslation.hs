module ProteinTranslation(proteins) where

chunks3 :: [a] -> Maybe [[a]]
chunks3 [] = Just []
chunks3 (x:y:z:xs) = ([x, y, z]:) <$> chunks3 xs
chunks3 _ = Nothing

translate :: String -> String
translate x
  | x == "AUG"                            = "Methionine"
  | x == "UGG"                            = "Tryptophan"
  | x `elem` ["UUU", "UUC"]               = "Phenylalanine"
  | x `elem` ["UUA", "UUG"]               = "Leucine"
  | x `elem` ["UCU", "UCC", "UCA", "UCG"] = "Serine"
  | x `elem` ["UAU", "UAC"]               = "Tyrosine"
  | x `elem` ["UGU", "UGC"]               = "Cysteine"
  | x `elem` ["UAA", "UAG", "UGA"]        = "STOP"
  | otherwise                             = ""

goThrough :: Maybe [String] -> Maybe [String]
goThrough Nothing = Nothing
goThrough (Just []) = Just []
goThrough (Just (x:xs))
  | tx == "STOP" = Just []
  | tx == ""     = Nothing
  | otherwise    = (tx:) <$> goThrough (Just xs)
  where tx = translate x

proteins :: String -> Maybe [String]
proteins = goThrough . chunks3
