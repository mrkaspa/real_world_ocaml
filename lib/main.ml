open Core

let add2 x =
  x + 2

let ratio ~x ~y = Float.of_int x /. Float.of_int y

let divisible_by (by: int) (n: int) : bool = n mod by = 0

let even : int -> bool = divisible_by 2

let count_pairs (ls: int list) : int =
  ls |> List.filter ~f:even
  (* |> List.filter ~f: (divisible_by 2) *)
  (* |> List.filter ~f: (fun a -> (a mod 2) = 0) *)
  |> List.length


let sum_if_true (test: int -> bool) (first: int) (second: int) : int =
  (if test first then first else 0) + if test second then second else 0


let hd ls = match ls with a :: _ -> Some a | _ -> None

let sum_rec elems =
  let rec sumi acc elems =
    match elems with x :: xs -> sumi (acc + x) xs | _ -> acc
  in
  sumi 0 elems


type point2d = {x: float; y: float}

type circle = {center: point2d; r: float}

type rect = {p1: point2d; p2: point2d}

type geom = Point of point2d | Circle of circle | Rect of rect

let area_geom (geom: geom) =
  match geom with
  | Point _ -> 0.
  | Circle {center= {x= _x1; y= _y1}; r} -> 3.1416 *. r ** 2.
  | Rect {p1= {x= x1; y= y1}; p2= {x= x2; y= y2}} -> x1 *. x2 *. y1 *. y2


type 'a refi = {mutable content: 'a}

let refi x = {content= x}

let ( ! ) r = r.content

let ( := ) r x = r.content <- x

let ( !+ ) r = r := !r + 1

let sum_point {x= x1; y= y1} = x1 +. y1

let run () =
  let refi1 = refi 0 in
  Printf.printf "sum if even %d\n" (sum_if_true even 1 2) ;
  Printf.printf "%f\n" (ratio ~x:1 ~y:2) ;
  Printf.printf "counting pairs %d\n" (count_pairs [1; 2; 3; 4]) ;
  Printf.printf "sum rec %d\n" (sum_rec [1; 2; 3; 4]) ;
  Printf.printf "sum point %f\n" (sum_point {x= 1.; y= 2.}) ;
  Printf.printf "area circle %f\n"
    (area_geom (Circle {center= {x= 1.; y= 2.}; r= 2.})) ;
  !+refi1 ;
  !+refi1 ;
  !+refi1 ;
  Printf.printf "refi %d\n" !refi1 ;
  Run.run () ;
  Sub.Demi.say "demo" ;
  Monoid.run () ;
  match hd [1; 2; 3] with
  | Some n -> Printf.printf "safe head %d\n" n
  | _ -> Printf.printf "not found"
