open Base

type bst = Leaf | Node of bst * int * bst

let empty = Leaf
let value = function Leaf -> Error "Empty Node" | Node (_, v, _) -> Ok v
let left = function Leaf -> Error "Empty Node" | Node (l, _, _) -> Ok l
let right = function Leaf -> Error "Empty Node" | Node (_, _, r) -> Ok r

let rec insert x = function
  | Leaf -> Node (Leaf, x, Leaf)
  | Node (left, v, right) ->
      if x <= v then Node (insert x left, v, right)
      else Node (left, v, insert x right)

let rec to_list = function
  | Leaf -> []
  | Node (left, v, right) -> to_list left @ (v :: to_list right)
