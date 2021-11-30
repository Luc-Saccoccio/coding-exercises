open Printf

let (&&&) f g = function x -> (f x, g x);;

let read_file filename =
        let ch = open_in filename in
        let s  = really_input_string ch (in_channel_length ch) in
        close_in ch;
        s;;

let explode s =
        let rec aux i l =
                if i < 0 then l else aux (i-1) (s.[i]::l) in
        aux (String.length s - 1) [];;

let print_tuple (a, b) =
        printf "(%d, %d)\n" a b;;

let part1 =
        let rec aux acc = function
                | [] -> acc
                | '('::q -> aux (acc+1) q
                | _::q -> aux (acc-1) q
        in aux 0;;

let part2 =
        let rec aux n p s =
                if n = -1 then p
                else match s with
                | '('::q -> aux (n+1) (p+1) q
                | ')'::q -> aux (n-1) (p+1) q
                | _ -> failwith "Impossible"
        in aux 0 0;;

let () =
        read_file "input.txt"
        |> explode
        |> (part1 &&& part2)
        |> print_tuple
;;
