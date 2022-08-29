let rec to_roman = function
  | 0 -> ""
  | n when n >= 1000 -> "M" ^ to_roman (n - 1000)
  | n when n >= 900 -> "CM" ^ to_roman (n - 900)
  | n when n >= 500 -> "D" ^ to_roman (n - 500)
  | n when n >= 400 -> "CD" ^ to_roman (n - 400)
  | n when n >= 100 -> "C" ^ to_roman (n - 100)
  | n when n >= 90 -> "XC" ^ to_roman (n - 90)
  | n when n >= 50 -> "L" ^ to_roman (n - 50)
  | n when n >= 40 -> "XL" ^ to_roman (n - 40)
  | n when n >= 10 -> "X" ^ to_roman (n - 10)
  | 9 -> "IX"
  | n when n >= 5 -> "V" ^ to_roman (n - 5)
  | 4 -> "IV"
  | n -> "I" ^ to_roman (n - 1)
