let mid a b = (a + b) / 2

let find arr x =
  let rec aux a b c =
    if a >= b then if arr.(a) == x then Ok a else Error "value not in array"
    else if arr.(c) < x then aux (c + 1) b (mid c b)
    else if arr.(c) > x then aux a (c - 1) (mid a c)
    else Ok c
  in
  let s = 0 and e = Array.length arr - 1 in
  if e = -1 then Error "value not in array" else aux s e (mid s e)
