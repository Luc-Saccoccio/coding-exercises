let encode = function
        [] -> []
        | (x::xs) -> let rec go n m = function
                  [] -> [(n, m)]
                | (y::ys) -> if y = m then
                                go (n+1) m ys
                             else
                                (n, m)::go 1 y ys
        in go 1 x xs;;
