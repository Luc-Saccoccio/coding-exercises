module SecretHandshake (handshake) where

handshake' :: Int -> [String]
handshake' n'
  | n >= 16 = reverse $ handshake' (n - 16)
  | n >= 8 = "jump":handshake' (n - 8)
  | n >= 4 = "close your eyes":handshake' (n - 4)
  | n >= 2 = "double blink":handshake' (n - 2)
  | n == 1 = "wink":handshake' (n - 1)
  | otherwise = []
  where
    n = n' `mod` 32

handshake :: Int -> [String]
handshake = reverse . handshake'
