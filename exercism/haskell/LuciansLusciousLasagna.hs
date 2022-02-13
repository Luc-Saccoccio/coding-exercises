module LuciansLusciousLasagna (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes) where

expectedMinutesInOven :: Int
expectedMinutesInOven = 40

preparationTimeInMinutes :: Int -> Int
preparationTimeInMinutes = (*2)

elapsedTimeInMinutes :: Int -> Int -> Int
elapsedTimeInMinutes = (+) . preparationTimeInMinutes
