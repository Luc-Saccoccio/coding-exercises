type 'a edge = ('a * 'a) list;;
type 'a graph_term = {nodes : 'a list;  edges : ('a * 'a) list};;
type 'a adjacency = ('a * 'a list) list;;


let rec graphToAdj graph =
        match graph.nodes with
        | [] -> []
        | (x::xs) ->
                let aux (a, b) =
                        if a = x then [b]
                        else if b = x then [a]
                        else []
                in
                ((x, List.concat @@ List.map aux graph.edges))::graphToAdj {nodes = xs; edges = graph.edges};;

let rec adjToGraph = function
        | [] -> {nodes = []; edges = []}
        | ((v, a)::vs) ->
                let graph = adjToGraph vs in
                let f x = if List.mem (v, x) graph.edges || List.mem (x, v) graph.edges
                            then []
                            else [(v, x)]
                in {nodes = (v::graph.nodes); edges = ((List.concat @@ List.map f a)@graph.edges)};;

let graphToEdge graph =
        match graph.nodes with
        | [] -> []
        | xs ->
                let g = List.filter (fun x -> List.for_all
                        (fun (a, b) -> x <> a && x <> b) graph.edges) xs
                in graph.edges@(List.combine g g);;

let edgeToGraph (e : 'a edge) : ('a graph_term) =
        match e with
        | [] -> {nodes = []; edges = []}
        | vs ->
                let acc x xs = if List.mem x xs then xs else x::xs
                in
                let ys = List.filter (fun (a, b) -> a <> b) vs
                and xs = List.fold_right acc (List.concat @@ List.map
                        (fun (a, b) -> [a; b]) vs) []
                in {nodes = xs; edges = ys};;

let adjToEdge a = graphToEdge @@ adjToGraph a;;

let edgToAdj f = graphToAdj @@ edgeToGraph f;;
