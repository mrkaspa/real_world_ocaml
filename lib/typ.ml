open Core

module Username : sig
  type t
  val of_string : string -> t
  val to_string : t -> string
end = struct
  type t = string
  let of_string x = x
  let to_string x = x
end

let print_name (name: Username.t) =
  print_string (Username.to_string name)

module type ID = sig
  type t
  val of_string : string -> t
  val to_string : t -> string
end

module String_id = struct
  type t = string
  let of_string x = x
  let to_string x = x
end

module Usernami : ID = String_id
module Hostname : ID = String_id

type session_info = {
  user: Usernami.t;
  host: Hostname.t;
  when_started: Time.t;
}

let create_session username host =
  {user = username; host = host; when_started = Time.now ()}

let id_to_string (type a) ((module B): (module ID with type t = a)) (id: a) =
  B.to_string id

module Logon = struct
  type t = {
    session_id: string;
    time: Time.t;
    user: string;
    credentials: string;
  }
end

let get_users logons =
  List.dedup_and_sort (List.map logons ~f:(fun x -> x.Logon.user))

let () =
  let session = create_session (Usernami.of_string "demo") (Hostname.of_string "host") in
  print_string ("The username is " ^ id_to_string (module Usernami) session.user)

module Foo_and_bar : sig
  type t = { foo: Int.Set.t; bar: string }
  include Comparable.S with type t := t
end = struct
  module T = struct
    type t = { foo: Int.Set.t; bar: string } [@@deriving sexp, compare]
  end
  include T
  include Comparable.Make(T)
end
