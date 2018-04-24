let () =
  (* Lib.Main.run (); *)
  let zero = Lib.Ls_assoc.find_in_assoc 0 in
  print_string ("ZERO = " ^ zero ^ "\n");
  let res = Lib.Ls_assoc.find_in_map () in
  match res with
  |Some x -> print_string x
  |None -> print_string "EEEE"
