let test1 () =
  assert (Lib.Main.add2 5 = 7);
  assert (Lib.Main.add2 (-2) = 0);
  assert (Lib.Main.add2 (-4) = (-2))

let test2 =
  QCheck.Test.make
    ~count:1000
    ~name:"sum2 is equal to n + 2"
    QCheck.(small_nat)
    (fun n -> (Lib.Main.add2 n) = (n + 2))

let _ =
  (* simple example *)
  test1 ();
  (* we can check right now the property... *)
  QCheck.Test.check_exn test2
