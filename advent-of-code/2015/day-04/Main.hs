import           Control.Arrow         ((&&&))
import           Crypto.Hash.MD5
import qualified Data.ByteString       as B
import qualified Data.ByteString.Char8 as BC
import           Data.Char             (intToDigit)
import           Data.List             (find)
import Data.Maybe (fromJust)
import Data.Bits ((.&.), shiftR)
import           Data.Word             (Word8)

byteHex :: Word8 -> String
byteHex b =
    map intToDigit [ fromIntegral b `shiftR` 4,
                     fromIntegral b .&. 0xf ]

showHex :: [Word8] -> String
showHex = concatMap byteHex

hashString :: String -> String
hashString = showHex . B.unpack . hash . BC.pack

solve :: Int ->  String -> Int
solve n s = fromJust $ find valid [1..]
    where
        valid :: Int -> Bool
        valid x = replicate n '0' == take n (hashString $ s ++ show x)

part1 :: String -> Int
part1 = solve 5

part2 :: String -> Int
part2 = solve 6

main :: IO ()
main = print $ (part1 &&& part2) "bgvyzdsv"
