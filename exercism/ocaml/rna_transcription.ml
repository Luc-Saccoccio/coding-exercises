type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

let transform =
  function
    `A -> `U | `C -> `G | `G -> `C | `T -> `A

let rec to_rna = List.map transform
