open Core

module type Summer = sig
  type t
  val sum : t -> t -> t
end

module type Summable = sig
  type t
  val zero : t
  val unit : t
end

module type Incrementor = sig
  type t
  val inc : t -> t
end

module IntSummable = struct
  type t = int
  let zero = 0
  let unit = 1
end

module FloatSummable = struct
  type t = float
  let zero = 0.
  let unit = 1.
end

module IntSummer = struct
  type t = int
  let sum n1 n2 =
    n1 + n2
end

module FloatSummer = struct
  type t = float
  let sum n1 n2 =
    n1 +. n2
end

module Make_incrementor (A : Summable) (M : Summer with type t = A.t) : (Incrementor with type t = A.t) = struct
  include M
  let inc n = M.sum n A.unit
end


module Int_incrementor = Make_incrementor (IntSummable) (IntSummer)

module Float_incrementor = Make_incrementor (FloatSummable) (FloatSummer)

let int_inc = (module Int_incrementor : Incrementor with type t = int)

let increment (type a) ((module A) : (module Incrementor with type t = a)) (n : a) =
  A.inc n

let apply_twice f n =
  f (f n)

let increment_twice (type a) ((module A) : (module Incrementor with type t = a)) (n : a) =
  apply_twice (increment (module A)) n

let () =
  printf "int %d\n" (increment int_inc 10);
  printf "float %f\n" (increment (module Float_incrementor) 10.);
  printf "float twice %f\n" (increment_twice (module Float_incrementor) 10.);
