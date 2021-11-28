type 'a binary_tree =
        | Empty
        | Node of 'a * 'a binary_tree * 'a binary_tree;;

let leaves =
        let rec aux acc = function
                | Empty -> acc
                | Node (x, Empty, Empty) -> x::acc
                | Node (x, l, r) -> aux (aux acc r) l
        in aux [];;
