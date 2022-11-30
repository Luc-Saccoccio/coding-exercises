let solution =
  let rec aux acc x y =
    if x > 4_000_000 then acc
    else
      let y' = x + y and x' = y in
      aux (if x mod 2 = 0 then acc + x else acc) x' y'
  in
  aux 0 1 2
;;

print_int solution
