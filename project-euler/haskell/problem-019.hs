-- How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

import Data.Time.Calendar
import Data.Time.Calendar.WeekDate

third :: (a, b, c) -> c
third (_, _, c) = c

main :: IO ()
main = print $ length [() | y <- [1901..2000], m <- [1..12], (==7) . third . toWeekDate $ fromGregorian y m 1]
