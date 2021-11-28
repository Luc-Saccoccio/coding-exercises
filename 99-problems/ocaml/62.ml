type 'a binary_tree =
        | Empty
        | Node of 'a * 'a binary_tree * 'a binary_tree;;

let internals =
        let rec aux acc = function
                | Empty -> []
                | Node (x, Empty, Empty) -> acc
                | Node (x, l, r) -> aux (x::aux acc r) l
        in aux [];;
