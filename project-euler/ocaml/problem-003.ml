let solution =
  let rec aux d acc n =
    if n = 1 then acc
    else if n mod d = 0 then aux d d (n / d)
    else aux (d + 1) acc n
  in
  aux 2 0 600851475143
;;

print_int solution
