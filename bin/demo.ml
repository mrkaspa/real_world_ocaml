open Core

let say_hello name =
  let name = "michel" in
  print_string ("Hola mundo " ^ name ^ "\n")

let () =
  for i = 0 to 10 do
    say_hello ()
  done;
  List.iter (List.range 1 10) (fun elem ->
      print_string (string_of_int elem));
  ()
