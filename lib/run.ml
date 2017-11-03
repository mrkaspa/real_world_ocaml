open Core

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)

let is_empty =
  function
  | [] -> true
  | _ -> false

let run () =
  printf "Total: %F\n" (read_and_accumulate 0.)
