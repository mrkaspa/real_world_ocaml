open Core

let build_counts () =
  In_channel.fold_lines In_channel.stdin ~init:Map_counter.empty ~f:Map_counter.touch

let run_counts () =
  build_counts ()
  |> Map_counter.to_list
  |> List.sort ~cmp:(fun (_,x) (_,y)  -> Int.descending x y)
  |> (fun l  -> List.take l 10)
  |> List.iter ~f:(fun (line,count)  -> printf "%3d: %s\n" count line)

let () =
  run_counts ()
