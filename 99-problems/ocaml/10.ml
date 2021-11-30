let encode list =
        let rec aux v acc = function
                | [] -> []
                | [x] -> (count+1, x)::acc
                | x::(y::_ as xs) -> if x = y then aux (count+1) acc t
                                        else aux 0 ((count+1), x)::acc xs
        in List.rev (aux 0 [] list);;
