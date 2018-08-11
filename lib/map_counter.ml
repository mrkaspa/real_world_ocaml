open Core

type t = int String.Map.t

let empty = String.Map.empty

let to_list t = Map.to_alist t

let touch t s =
  let count = match Map.find t s with None -> 0 | Some x -> x in
  Map.set t ~key:s ~data:(count + 1)

let make_int_map ls = Map.of_alist_exn (module Int) ls

let run () =
  let m = make_int_map [1, ""; 2, ""] in
  Map.find m 1
