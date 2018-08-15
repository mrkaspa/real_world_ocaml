let test1 () =
  assert (Lib.Main.add2 5 == 7)

let test =
  QCheck.Test.make
    ~count:1000
    ~name:"sum2"
    QCheck.(small_nat)
    (fun n -> (Lib.Main.add2 n) = (n + 2))

let _ =
  (* simple example *)
  test1 ();
  (* we can check right now the property... *)
  QCheck.Test.check_exn test
