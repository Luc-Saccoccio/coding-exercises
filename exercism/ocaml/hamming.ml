type nucleotide = A | C | G | T

let equal (x, y) =
  match (x, y) with A, A | C, C | G, G | T, T -> true | _ -> false

let f accu ele = accu + if equal ele then 0 else 1

let hamming_distance list1 list2 =
  match (List.length list1, List.length list2) with
  | 0, n when n > 0 -> Error "left strand must not be empty"
  | n, 0 when n > 0 -> Error "right strand must not be empty"
  | m, n when m != n -> Error "left and right strands must be of equal length"
  | _, _ -> List.combine list1 list2 |> fun x -> Ok (List.fold_left f 0 x)
