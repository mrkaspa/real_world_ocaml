open Core

exception DemoEx of string

let safe_div n d =
  if d = 0 then Error (Error.of_string "d is 0") else Ok (n / d)

let unsafe_div n d = if d = 0 then raise (DemoEx "d is 0") else n / d

let use_safe_div () =
  let open Result.Monad_infix in
  let res = safe_div 1 1 >>= fun res -> Ok (res + 1) in
  match res with
  | Ok res -> printf "The res %d" res
  | Error error -> printf "Err %s" (Error.to_string_hum error)

let use_unsafe_div () =
  match unsafe_div 1 0 with
  | res -> printf "The res %d" res
  | exception DemoEx msg -> printf "Err %s" msg

let () = use_unsafe_div ()
