type 'a rle =
          One of 'a
        | Many of int * 'a;;

let encode' = function
        [] -> []
        | (x::xs) -> let rec go n m = function
                  [] -> [(n, m)]
                | (y::ys) -> if y = m then
                                go (n+1) m ys
                             else
                                (n, m)::go 1 y ys
        in go 1 x xs;;

let encode l =
        let f = function (1, x) -> One x | (n, x) -> Many (n, x) in
        List.map f (encode' l);;
