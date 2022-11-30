(* 1 *)
let rec last = function [] -> None | [ x ] -> Some x | _ :: xs -> last xs

(* 2 *)
let rec last_two = function
  | [] | [ _ ] -> None
  | [ x; y ] -> Some (x, y)
  | _ :: xs -> last_two xs

(* 3 *)
let rec at k = function
  | [] -> None
  | x :: xs -> if k = 1 then x else at (k - 1) xs

(* 4 *)
let rec length = function [] -> 0 | x :: xs -> 1 + length xs

(* 5 *)
let rev =
  let rec aux acc = function [] -> acc | x :: xs -> aux (x :: acc) xs in
  aux []

(* 6 *)
let is_palindrome l = rev l = l

(* 7 *)
type 'a node = One of 'a | Many of 'a node list

let flatten l =
  let rec aux acc = function
    | [] -> acc
    | One x :: xs -> aux (x :: acc) xs
    | Many x :: xs -> aux (aux acc x) xs
  in
  aux [] l |> rev

(* 8 *)
let rec compress = function
  | a :: b :: xs when a = b -> compress (b :: xs)
  | l -> l

(* 9 *)
let pack =
  let rec aux acc = function
    | [] -> [ acc ]
    | x :: xs when List.hd acc = x -> aux (x :: acc) xs
    | x :: xs -> acc :: aux [ x ] xs
  in
  function [] -> [] | x :: xs -> aux [ x ] xs

(* 10 *)
let encode =
  let rec aux n c = function
    | [] -> [ (n, c) ]
    | x :: xs when x = c -> aux (n + 1) c xs
    | x :: xs -> (n, c) :: aux 1 x xs
  in
  function [] -> [] | x :: xs -> aux 1 x xs

(* 11 *)
type 'a rle = One of 'a | Many of int * 'a

let encode_rle =
  let rec aux n c = function
    | [] -> [ (if n = 1 then One c else Many (n, c)) ]
    | x :: xs when x = c -> aux (n + 1) c xs
    | x :: xs -> (if n = 1 then One c else Many (n, c)) :: aux 1 x xs
  in
  function [] -> [] | x :: xs -> aux 1 x xs

let encode_rle' l =
  let f = function 1, x -> One x | n, x -> Many (n, x) in
  List.map f (encode l)

(* 12 *)
let decode l =
  let f = function 1, x -> One x | n, x -> Many (n, x) in
  let rec aux acc = function
    | [] -> acc
    | One x :: xs -> aux (x :: acc) xs
    | Many (n, x) :: xs -> aux (x :: acc) (f (n - 1, x) :: xs)
  in
  List.rev l |> aux []

(* 13 *)
(* Not sure if I get this one *)

(* 14 *)
let rec duplicate = function [] -> [] | x :: xs -> x :: x :: duplicate xs

(* 15 *)
let replicate l n =
  let rec repli x acc = function 0 -> acc | m -> repli x (x :: acc) (m - 1) in
  let rec aux acc = function [] -> acc | x :: xs -> aux (repli x acc n) xs in
  List.rev l |> aux []

(* 16 *)
let drop l n =
  let rec aux m = function
    | [] -> []
    | x :: xs when m = 1 -> aux n xs
    | x :: xs -> x :: aux (m - 1) xs
  in
  aux n l

(* 17 *)
let split l n =
  let rec aux acc i = function
    | [] -> (List.rev acc, [])
    | l when i = 0 -> (List.rev acc, l)
    | x :: xs -> aux (x :: acc) (i - 1) xs
  in
  aux [] n l

(* 18 *)
let slice l n k =
  if n > k then []
  else
    let rec drop i = function
      | [] -> [] (* Impossible *)
      | l when i = 0 -> l
      | x :: xs -> drop (i - 1) xs
    and take i = function
      | [] -> [] (* Impossible *)
      | _ when i = 0 -> []
      | x :: xs -> x :: take (i - 1) xs
    in
    drop n l |> take (k - n + 1)

(* 19 *)
let rotate l n =
  let len = length l in
  let n' = if len = 0 then 0 else ((n mod len) + len) mod len in
  if n' = 0 then l
  else
    let a, b = split l n' in
    b @ a

(* 20 *)
let rec remove_at n = function
  | [] -> []
  | x :: xs when n = 0 -> xs
  | x :: xs -> x :: remove_at (n - 1) xs

(* 21 *)
let rec insert_at c n = function
  | [] -> [ c ]
  | xs when n = 0 -> c :: xs
  | x :: xs -> x :: insert_at c (n - 1) xs

(* 22 *)
let rec range i k =
  if i = k then [ i ]
  else if i < k then i :: range (i + 1) k
  else i :: range (i - 1) k

(* 23 *)
let rand_select l n =
  let rec extract i acc = function
    | [] -> failwith "nope"
    | x :: xs when i = 0 -> (x, acc @ xs)
    | x :: xs -> extract (i - 1) (x :: acc) xs
  in
  let extract_rand len = extract (Random.int len) [] in
  let rec aux acc l len = function
    | 0 -> acc
    | i ->
        let x, xs = extract_rand len l in
        aux (x :: acc) xs (len - 1) (i - 1)
  in
  let len = length l in
  aux [] l len (min n len)

(* 24 *)
let lotto_select n m = rand_select (range 1 m) n

(* 25 *)
let permutation l =
  let rec extract i acc = function
    | [] -> failwith "nope"
    | x :: xs when i = 0 -> (x, acc @ xs)
    | x :: xs -> extract (i - 1) (x :: acc) xs
  in
  let extract_rand len = extract (Random.int len) [] in
  let rec aux acc l = function
    | 0 -> acc
    | n ->
        let x, xs = extract_rand n l in
        aux (x :: acc) xs (n - 1)
  in
  let len = length l in
  aux [] l len

(* 26 *)
(* TODO *)

(* ARITHMETIC *)

(* 31 *)
let is_prime n =
  if n < 4 then n > 1
  else
    let n = abs n in
    let sqrt_n = float_of_int n |> sqrt |> int_of_float in
    let rec aux i =
      let si = 6 * i in
      if si > sqrt_n then [] else ((6 * i) - 1) :: ((6 * i) + 1) :: aux (i + 1)
    in
    List.for_all (function x -> n mod x <> 0) (2 :: 3 :: aux 1)

(* 32 *)
let rec gcd a b = if b = 0 then a else gcd b (a mod b)

(* 33 *)
let coprime a b = gcd a b = 1

(* 34 *)
let phi n =
  if n = 1 then 1
  else
    let rec aux acc d =
      if d < n then aux (if coprime n d then acc + 1 else acc) (d + 1) else acc
    in
    aux 0 1

let phi' n =
  let res = ref 0 in
  for i = 0 to n - 1 do
    if coprime n i then incr res
  done;
  !res

(* 35 *)
let factors n =
  let rec aux n d =
    if n = 1 then []
    else if n mod d = 0 then d :: aux (n / d) d
    else aux n (d + 1)
  in
  aux n 2

(* 36 *)
let factors n =
  let rec aux n d =
    if n = 1 then []
    else if n mod d = 0 then
      match aux (n / d) d with
      | (h, c) :: xs when h = d -> (h, c + 1) :: xs
      | xs -> (d, 1) :: xs
    else aux n (d + 1)
  in
  aux n 2

(* 37 *)
let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n ->
      let b = pow a (n / 2) in
      b * b * if n mod 2 = 0 then 1 else a

let phi_improved n =
  let rec aux = function
    | [] -> 1
    | (p, m) :: xs -> (p - 1) * pow p (m - 1) * aux xs
  in
  factors n |> aux

(* 38 *)
(* TODO ? *)

(* 39 *)
let rec all_primes a b =
  (* Naive *)
  if a > b then []
  else
    let primes = all_primes (a + 1) b in
    if is_prime a then a :: primes else primes

(* TODO: Use "The Sieve" *)

(* 40 *)
let goldbach n =
  let rec aux d =
    if d > n then failwith "Goldbach's conjecture is in fact false ._."
    else if is_prime d && is_prime (n - d) then (d, n - d)
    else aux (d + 1)
  in
  if n < 3 || n mod 2 = 1 then
    failwith "An even number greater than 2 is needed"
  else aux 2
(* TODO: Alternative using the all_primes function ? *)

(* 41 *)
let rec goldbach_list a b =
  if a > b then []
  else if a mod 2 = 1 then goldbach_list (a + 1) b
  else (a, goldbach a) :: goldbach_list (a + 2) b

let goldbach_limit a b lim =
  goldbach_list a b |> List.filter (fun (_, (n, d)) -> n > lim && d > lim)

(* LOGIC AND CODES *)
type bool_expr =
  | Var of string
  | Not of bool_expr
  | And of bool_expr * bool_expr
  | Or of bool_expr * bool_expr

(* 46 & 47 *)
let evaluate associations expr =
  let rec aux = function
    | Var x -> List.assoc x associations
    | Not x -> aux x |> not
    | And (x, y) -> aux x && aux y
    | Or (x, y) -> aux x || aux y
  in
  aux expr

let table2 va vb expr =
  [
    (true, true, evaluate [ (va, true); (vb, true) ] expr);
    (true, false, evaluate [ (va, true); (vb, false) ] expr);
    (false, true, evaluate [ (va, false); (vb, true) ] expr);
    (false, false, evaluate [ (va, false); (vb, false) ] expr);
  ]

(* 48 *)
let table vars expr =
  let rec aux values = function
    | [] -> [ (List.rev values, evaluate values expr) ]
    | x :: xs -> aux ((x, true) :: values) xs @ aux ((x, false) :: values) xs
  in
  aux [] vars

(* 49 *)
let gray =
  let f s acc = ("0" ^ s) :: ("1" ^ s) :: acc in
  let rec aux = function
    | 0 -> [ "" ]
    | n -> List.fold_right f (aux (n - 1)) []
  in
  aux

(* BINARY TREES *)
type 'a binary_tree = Empty | Node of 'a * 'a binary_tree * 'a binary_tree

let example_tree =
  Node
    ( 'a',
      Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
      Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty)) )

let example_int_tree =
  Node
    ( 1,
      Node (2, Node (4, Empty, Empty), Node (5, Empty, Empty)),
      Node (3, Empty, Node (6, Node (7, Empty, Empty), Empty)) )

(* 55 *)
let build l r acc =
  let aux accu left =
    List.fold_left (fun a right -> Node ('x', left, right) :: a) accu r
  in
  List.fold_left aux acc l

let rec cbal_tree = function
  | 0 -> [ Empty ]
  | 1 -> [ Node ('x', Empty, Empty) ]
  | n when n mod 2 = 1 ->
      let t = cbal_tree ((n - 1) / 2) in
      build t t []
  | n ->
      let l = cbal_tree ((n - 1) / 2) and r = cbal_tree (n / 2) in
      build l r (build r l [])

(* 56 *)
let rec is_mirror l r =
  match (l, r) with
  | Empty, Empty -> true
  | Node (_, ll, rl), Node (_, lr, rr) -> is_mirror ll rr && is_mirror lr rl
  | _ -> false

let rec is_symmetric = function
  | Empty -> true
  | Node (_, l, r) -> is_mirror l r

(* 61 *)
let rec count_leaves = function
  | Empty -> 0
  | Node (_, Empty, Empty) -> 1
  | Node (_, l, r) -> count_leaves l + count_leaves r

(* 61A *)
let leaves =
  let rec aux acc = function
    | Empty -> acc
    | Node (x, Empty, Empty) -> x :: acc
    | Node (_, l, r) -> aux (aux acc r) l
  in
  aux []

(* 62 *)
let internals =
  let rec aux acc = function
    | Empty | Node (_, Empty, Empty) -> acc
    | Node (x, l, r) -> aux (x :: aux acc r) l
  in
  aux []

(* 62B *)
let at_level n =
  let rec aux acc counter = function
    | Empty -> acc
    | Node (x, l, r) when counter = n -> x :: acc
    | Node (_, l, r) -> aux (aux acc (n + 1) r) (n + 1) l
  in
  aux [] 0

(* 63 *)
let complete_binary_tree l =
  let arr = Array.of_list l in
  let n = Array.length arr in
  let rec aux x =
    if x > n then Empty else Node (arr.(x - 1), aux (2 * x), aux ((2 * x) + 1))
  in
  aux 1

let is_complete_binary_tree n t = (* Compare structure *)
  let rec aux t1 t2 =
    match (t1, t2) with
    | Empty, Empty -> true
    | Node (_, l, r), Node (_, g, d) -> aux l g && aux r d
    | _, _ -> false
  and tree = complete_binary_tree (List.init n (fun _ -> 1)) in
  aux tree t

(* 64 *)
let layout_binary_tree t =
  let rec aux x y = function
    | Empty -> (Empty, x)
    | Node (v, l, r) ->
        let l', x' = aux x (y + 1) l in
        let r', x'' = aux (x' + 1) y r in
        (Node ((v, (x', y)), l', r'), x'')
  in
  aux 1 1 t |> fst

(* 65 *)
let rec depth = function
  | Empty -> 0
  | Node (_, l, r) -> 1 + max (depth l) (depth r)

let rec left_depth = function Empty -> 0 | Node (_, l, _) -> 1 + left_depth l

let layout_binary_tree_2 t =
  let d = depth t and ld = left_depth t in
  let a = (1 lsl d) - (1 lsl ld) + 1 and b = 1 lsl (d - 2) in
  let rec aux x y s = function
    | Empty -> Empty
    | Node (v, l, r) ->
        let y' = y + 1 and s' = s / 2 in
        Node ((v, (x, y)), aux (x - s) y' s' l, aux (x + s) y' s' r)
  in
  aux a 1 b t

(* 66 *)
  (* TODO *)

(* 67 *)
let rec string_of_tree = function
  | Empty -> ""
  | Node (x, Empty, Empty) -> String.make 1 x
  | Node (x, l, r) ->
      Printf.sprintf "%c(%s,%s)" x (string_of_tree l) (string_of_tree r)

  (* TODO *)

(* MULTIWAY TREES *)
type 'a mult_tree = T of 'a * 'a mult_tree list

(* 70C *)
let rec count_nodes (T (_, list)) =
  List.fold_left (fun n t -> n + count_nodes t) 1 list
