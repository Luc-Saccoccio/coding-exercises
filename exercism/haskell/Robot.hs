{-# LANGUAGE TemplateHaskell #-}

module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

import           Lens.Micro    (_1, _2, (%~), (&), (^.))
import           Lens.Micro.TH (makeLenses)

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot { _co :: (Integer, Integer), _dir :: Bearing }

makeLenses ''Robot

coordinates :: Robot -> (Integer, Integer)
coordinates = (^. co)

bearing :: Robot -> Bearing
bearing = (^. dir)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction coo =
  Robot { _co = coo
        , _dir = direction
        }

turnRight :: Bearing ->  Bearing
turnRight North = East
turnRight East  = South
turnRight South = West
turnRight West  = North

turnLeft :: Bearing -> Bearing
turnLeft East  = North
turnLeft South = East
turnLeft West  = South
turnLeft North = West

advance :: Bearing -> (Integer, Integer) -> (Integer, Integer)
advance North = _2 %~ (+1)
advance East  = _1 %~ (+1)
advance South = _2 %~ subtract 1
advance West  = _1 %~ subtract 1

move :: Robot -> String -> Robot
move = foldl (flip mkMove)
  where
    mkMove :: Char -> Robot -> Robot
    mkMove 'R' r = r & dir %~ turnRight
    mkMove 'L' r = r & dir %~ turnLeft
    mkMove 'A' r = r & co %~ advance (r^.dir)
    mkMove _ r   = r
