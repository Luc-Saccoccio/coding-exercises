module SpaceAge
  ( Planet(..)
  , ageOn
  ) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

earthSeconds :: Float
earthSeconds = 31557600

ageOn :: Planet -> Float -> Float
ageOn Mercury = (/ earthSeconds) . (/ 0.2408467)
ageOn Venus   = (/ earthSeconds) . (/ 0.61519726)
ageOn Earth   = (/ earthSeconds)
ageOn Mars    = (/ earthSeconds) . (/ 1.8808158)
ageOn Jupiter = (/ earthSeconds) . (/ 11.862615)
ageOn Saturn  = (/ earthSeconds) . (/ 29.447498)
ageOn Uranus  = (/ earthSeconds) . (/ 84.016846)
ageOn Neptune = (/ earthSeconds) . (/ 164.79132)
