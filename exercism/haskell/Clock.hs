module Clock
  ( addDelta
  , fromHourMin
  , toString
  ) where

import           Text.Printf                    ( printf )

data Clock = Clock Int Int
  deriving Eq

fromHourMin :: Int -> Int -> Clock
fromHourMin hour minute =
  Clock ((hour + div minute 60) `mod` 24) (minute `mod` 60)

toString :: Clock -> String
toString (Clock h m) = printf "%02d:%02d" h m

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour minute (Clock h m) = fromHourMin (hour + h) (minute + m)
