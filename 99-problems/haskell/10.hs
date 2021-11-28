import Data.List (group)
import Control.Arrow ((&&&))

encode :: Eq a => [a] -> [(Int, a)]
encode = map (length &&& head) . group
