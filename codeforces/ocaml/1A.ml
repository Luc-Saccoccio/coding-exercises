open Scanf
open Printf

let () =
        let (n, m, a) = Scanf.scanf "%d %d %d" (fun a b c -> (a, b, c)) in
        let x, y = (n + a - 1) / a, (m + a - 1) / a in
        Printf.printf "%d\n" (x*y)
