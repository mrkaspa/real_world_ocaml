let create_matrix n =
  Array.make_matrix n n 0

let run () =
  let mat = create_matrix 1000 in
  Array.fold_left
    (fun acc arr -> Array.fold_left (+) acc arr) 0 mat

let () =
  let t = Sys.time () in
  run () |> ignore;
  let delta = Sys.time () -. t in
  Printf.printf "Execution time: %fms\n" (delta *. 1000.0)
