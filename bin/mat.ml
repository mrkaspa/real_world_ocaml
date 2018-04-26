let run () =
  let n = 1000 in
  let mat = Array.make_matrix n n 0 in
  Array.fold_left
    (fun acc arr -> Array.fold_left (+) acc arr) 0 mat

let () =
  let t = Sys.time () in
  run () |> ignore;
  let delta = Sys.time () -. t in
  Printf.printf "Execution time: %fms\n" (delta *. 1000.0)
