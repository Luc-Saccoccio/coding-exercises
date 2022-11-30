let somme_divisible n =
  let p = 999 / n in
  n * (p * (p + 1)) / 2

let solution = somme_divisible 3 + somme_divisible 5 - somme_divisible 15;;

print_int solution
