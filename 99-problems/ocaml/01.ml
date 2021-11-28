let rec last l = match l with
        | [] -> None
        | [x] -> Some x
        | (_::xs) -> last xs;;
