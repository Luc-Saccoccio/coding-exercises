type 'a binary_tree =
        | Empty
        | Node of 'a * 'a binary_tree * 'a binary_tree;;

let at_level n =
        let rec aux acc counter = function
                | Empty -> acc
                | Node (x, l, r) ->
                        if counter =n then
                                x::acc
                        else
                                aux (aux acc (counter+1) r) (counter+1) l
                in aux [] 1;;
