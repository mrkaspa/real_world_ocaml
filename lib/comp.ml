open Core

module Ord = struct
  type t =
    | GT
    | EQ
    | LT
end

module type Comparable = sig
  type t
  val compare : t -> t -> Ord.t
end

module type Interval_iface = sig
  type endpoint
  type t =
    | Interval of endpoint * endpoint
    | Empty
  val create : endpoint -> endpoint -> t
  val is_empty : t -> bool
  val contains : t -> endpoint -> bool
end

module Make_interval (Endpoint : Comparable) : (Interval_iface with type endpoint := Endpoint.t) = struct
  type t =
    | Interval of Endpoint.t * Endpoint.t
    | Empty

  let create low high =
    if (Endpoint.compare low high) = Ord.GT then Empty
    else Interval (low, high)

  let is_empty = (function
      | Empty -> true
      | Interval _ -> false)

  let contains t x =
    match t with
    | Empty -> false
    | Interval (low, high) ->
      Endpoint.compare x low = Ord.GT && Endpoint.compare x high = Ord.LT
end

module IntInterval = Make_interval (struct
    type t = int
    let compare i1 i2 =
      match Int.compare i1 i2 with
      | 0  -> Ord.EQ
      | 1  -> Ord.GT
      | -1 -> Ord.LT
      | _  -> Ord.EQ
  end)

let () =
  let open IntInterval in
  let inter = IntInterval.create 10 2 in
  match inter with
  | Interval (low, high) -> printf "Interval %d - %d" low high
  | Empty -> print_string "Empty interval"
