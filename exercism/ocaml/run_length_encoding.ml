(* Not Efficient... *)

let is_digit ch = ch <= '9' && ch >= '0'
let digit_of_char c = Char.(code c - code '0')

let encode str =
  if String.length str < 2 then str else
  let n = ref 0
  and c = ref '\000'
  and res = ref "" in
  let f c' =
    (if !n > 1 then
      res := !res ^ string_of_int !n ^ Char.escaped !c
    else
      res := !res ^ Char.escaped !c);
    n := 1;
    c := c' in
  let aux c' =
    if !n == 0 then
      (n := 1;
      c := c')
    else if !c == c' then
      incr n
    else
      f c'
    in
    (String.iter aux str; f '\000'; !res)

let decode str =
  let n = ref 0
  and res = ref ""
  in let aux c =
    if is_digit c then
      n := !n * 10 + digit_of_char c
    else
      (res := !res ^ String.make (max 1 !n) c; n := 0)
  in String.iter aux str; !res
