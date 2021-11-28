let rec compress = function
        | (a::b::xs) when a = b -> compress (b::xs)
        | xs -> xs;;
