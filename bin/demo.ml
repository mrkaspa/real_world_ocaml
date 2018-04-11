open Core
open Lwt

let say_hello name =
  let name = "michel" in
  print_string ("Hola mundo " ^ name ^ "\n")


let lwt_process () =
  let request =
    let%lwt addresses = Lwt_unix.getaddrinfo "google.com" "80" [] in
    let compute =
      let open Option in
      List.hd addresses
      >>| fun address ->
      let google = address.ai_addr in
      let open Lwt_io in
      with_connection google (fun (incoming, outgoing) ->
          let%lwt () = write outgoing "GET / HTTP/1.1\r\n" in
          let%lwt () = write outgoing "Connection: close\r\n\r\n" in
          let%lwt response = read incoming in
          Lwt.return (Some response) )
    in
    match compute with Some process -> process | None -> Lwt.return None
  in
  let timeout =
    let%lwt () = Lwt_unix.sleep 5. in
    Lwt.return None
  in
  match Lwt_main.run (Lwt.pick [request; timeout]) with
  | Some response -> print_string response
  | None ->
      prerr_endline "Request timed out" ;
      exit 1


let () =
  for i = 0 to 10 do say_hello () done ;
  List.iter (List.range 1 10) (fun elem -> print_string (string_of_int elem)) ;
  lwt_process ()
