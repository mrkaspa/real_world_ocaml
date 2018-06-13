open Core

let safe_div n d =
  if d = 0 then Error (Error.of_string "d is 0") else Ok (n / d)

exception DemoEx of string

let unsafe_div n d =
  if d = 0 then raise (DemoEx "d is 0") else n / d

let use_safe_div () =
  let open Result.Monad_infix in
  let res = safe_div 1 1 >>= fun res -> Ok (res + 1) in
  match res with
  | Ok res -> printf "The res %d" res
  | Error error -> printf "Err %s" (Error.to_string_hum error)


let use_unsafe_div () =
  try
    let res = unsafe_div 1 0 in
    printf "The res %d" res
  with DemoEx msg -> printf "Err %s" msg


let () = use_unsafe_div ()
