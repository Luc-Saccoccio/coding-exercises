type 'a node =
        | One of 'a
        | Many of 'a node list;;

let flatten l =
        let rec aux acc = function
                | [] -> acc
                | (One x::xs) -> aux (x::acc) xs
                | (Many x::xs) -> aux (aux acc x) xs
        in rev @@ aux [] l;;
