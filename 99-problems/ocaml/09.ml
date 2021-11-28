let pack =
        let rec aux acc = function
                | [] -> [acc]
                | (x::xs) -> if List.hd acc = x then aux (x::acc) xs else acc::aux [x] xs
        in function
                | [] -> []
                | (x::xs) -> aux [x] xs;;
