open Core

let digit_alist = [0, "zero"]

let find_in_assoc n =
  let res = List.Assoc.find ~equal:(=) digit_alist n in
  match res with
  | Some a -> a
  | None -> "not"

let find_in_map () =
  let digit_map = Map.of_alist_exn (module Int) digit_alist
  in

  digit_map
  |> Map.set ~key:1 ~data: "one"
  |> (fun m -> Map.find m 1)
  |> (fun opt ->
      Option.(opt >>= fun n -> Some (n ^ n)))
