let rec fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)
let append_str s1 s2 = s1 ^ s2

let quasi = {|hello
world
how 
is it 
going|}

let ls = [ 1; 2; 3; 4; 5 ]

let rec sort_list ls =
  match ls with [] -> [] | x :: xs -> insert x (sort_list xs)

and insert y ys =
  match ys with
  | [] -> [ y ]
  | head :: tail -> if y < head then y :: ys else head :: insert y tail

let deriv f dx x = (f (x +. dx) -. f x) /. dx
let cos = deriv sin 1e-6
let compose f g x = g x |> f

let sin' x =
  compose
    (compose (fun f -> deriv f 1e-60) (fun f -> deriv f 1e-60))
    (fun f -> deriv f 1e-60)
    cos x

let rec map' f ls =
  match ls with [] -> [] | head :: tail -> f head :: map' f tail

type ratio = { num : int; denom : int }

let add_ratio r1 r2 =
  {
    num = (r1.num * r2.denom) + (r2.num * r1.denom);
    denom = r1.denom * r2.denom;
  }

let ratio_of_float { num; denom } = float_of_int num /. float_of_int denom
let integer_part { num; denom = dn } = num / dn
let get_num { num; _ } = num
let get_denom { denom } = denom
let integer_product int ratio = { ratio with num = int * ratio.num }

type number = Int of int | Float of float | Error

let add_number n1 n2 =
  match (n1, n2) with
  | Int x, Int y -> Int (x + y)
  | Float x, Float y -> Float (x +. y)
  | Int x, Float y -> Float (float_of_int x +. y)
  | Float y, Int x -> Float (float_of_int x +. y)
  | _, _ -> Error

type 'a option' = Some' of 'a | None'

let safe_root x = if x >= 0. then Some (sqrt x) else None

type 'a btree' = Empty | Node of 'a btree' * 'a * 'a btree'

let rec member a btree =
  match btree with
  | Empty -> false
  | Node (left, b, right) ->
      if b = a then true else if a < b then member a left else member a right

let rec insert a btree =
  match btree with
  | Empty -> Node (Empty, a, Empty)
  | Node (left, b, right) ->
      if a <= b then Node (insert a left, b, right)
      else Node (left, b, insert a right)

type first_record = { x : int; y : int; z : int }
type second_record = { x : int; y : int }
type third_record = { x : int }
type first_variant = A | B | C
type second_variant = A

let x_then_z (r : first_record) =
  let x = r.x in
  x + r.z

let permute (x : first_variant) =
  match x with A -> (B : first_variant) | B -> A | C -> C

type wrapped = First of first_record

let f (First r) = (r, r.x)
let project_and_rotate { x; y } = { x = y; y = x }

(* will use last defined type eg. third_record *)
let get_x { x } = x

(* let look_at_x_y r =
   let x = r.x (*chooses last record*) in
   x + r.y (* will cause type error*) *)

let add_vect v1 v2 =
  let len = min (Array.length v1) (Array.length v2) in
  let res = Array.make len 0.0 in
  for i = 0 to len - 1 do
    res.(i) <- v1.(i) +. v2.(i)
  done;
  res

let sum_vect v : int ref =
  let sum = ref 0 in
  for i = 0 to Array.length v do
    sum := !sum + v.(i)
  done;
  sum

type mutable_point = { mutable x : float; mutable y : float }

let translate p dx dy =
  p.x <- p.x +. dx;
  p.y <- p.y +. dy

let insertion_sort a =
  for i = 1 to Array.length a - 1 do
    let val_i = a.(i) in
    let j = ref i in
    while !j > 0 && val_i < a.(!j - 1) do
      a.(!j) <- a.(!j - 1);
      j := !j - 1
    done;
    a.(!j) <- val_i
  done

let current_rand = ref 0

let random () =
  current_rand := (!current_rand * 2394) + 324;
  !current_rand

type idref = { mutable id : 'a. 'a -> 'a }

let r = { id = (fun x -> x) }
let g s = (s.id 1, s.id true)

exception Empty_list

let unsafe_head xs = match xs with [] -> raise Empty_list | x :: xs -> x

let name_of_bin_digit digit =
  try List.assoc digit [ (0, "zero"); (1, "one") ]
  with Not_found -> "not a binary digit"

let rec first_named xs names =
  try List.assoc (unsafe_head xs) names with
  | Empty_list -> "no named value"
  | Not_found -> first_named (List.tl xs) names

let temp_set_ref ref newval funct =
  let oldval = !ref in
  try
    ref := newval;
    let res = funct () in
    ref := oldval;
    res
  with x ->
    ref := oldval;
    raise x

let assoc_may_map f x l =
  match List.assoc x l with exception Not_found -> None | y -> f y

let flat_assoc_opt x l =
  match List.assoc x l with
  | None | (exception Not_found) -> None
  | Some _ as v -> v

let fixpoint f x =
  let exception Done in
  let x = ref x in
  try
    while true do
      let y = f !x in
      if !x = y then raise Done else x := y
    done;
    assert false
  with Done -> !x

let lazy_two =
  lazy
    (print_endline "lazy_two evaluation";
     1 + 1)

let lazy_l = lazy ([ 1; 2 ] @ [ 3; 4 ])
let (lazy once_lazy) = lazy_l

let mayve_eval lazy_guard lazy_expr =
  match (lazy_guard, lazy_expr) with
  | (lazy false), _ -> "not forced"
  | (lazy true), (lazy _) -> "forces lazy expr"

type expression =
  | Const of float
  | Var of string
  | Sum of expression * expression
  | Diff of expression * expression
  | Prod of expression * expression
  | Quot of expression * expression

exception Unbound_variable of string

let rec eval env exp =
  match exp with
  | Const c -> c
  | Var v -> (
      try List.assoc v env with Not_found -> raise (Unbound_variable v))
  | Sum (f, g) -> eval env f +. eval env g
  | Diff (f, g) -> eval env f -. eval env g
  | Prod (f, g) -> eval env f *. eval env g
  | Quot (f, g) -> eval env f /. eval env g

let rec sym_deriv exp dv =
  match exp with
  | Const c -> Const 0.0
  | Var v -> if v = dv then Const 1.0 else Const 0.0
  | Sum (f, g) -> Sum (sym_deriv f dv, sym_deriv g dv)
  | Diff (f, g) -> Diff (sym_deriv f dv, sym_deriv g dv)
  | Prod (f, g) -> Sum (Prod (sym_deriv f dv, g), Prod (f, sym_deriv g dv))
  | Quot (f, g) ->
      Quot
        (Diff (Prod (sym_deriv f dv, g), Prod (f, sym_deriv g dv)), Prod (g, g))

let print_expr exp =
  let open_paren prec op_prec = if prec > op_prec then print_string "(" in
  let close_paren prec op_prec = if prec > op_prec then print_string ")" in
  let rec print prec exp =
    match exp with
    | Const c -> print_float c
    | Var v -> print_string v
    | Sum (f, g) ->
        open_paren prec 0;
        print 0 f;
        print_string " + ";
        print 0 g;
        close_paren prec 0
    | Diff (f, g) ->
        open_paren prec 0;
        print 0 f;
        print_string " - ";
        print 0 g;
        close_paren prec 0
    | Prod (f, g) ->
        open_paren prec 2;
        print 2 f;
        print_string " * ";
        print 2 g;
        close_paren prec 2
    | Quot (f, g) ->
        open_paren prec 2;
        print 2 f;
        print_string " / ";
        print 2 g;
        close_paren prec 2
  in
  print 0 exp

let hello12div5world = Printf.printf "hello %i / %i = %F %S" 12 5 2.4 "world"
let pp_int ppf n = Printf.fprintf ppf "%d" n
let custom_printer () = Printf.printf "Using custom printer %a" pp_int 42

let pp_option printer ppf = function
  | None -> Printf.fprintf ppf "None"
  | Some v -> Printf.fprintf ppf "Some(%a)" printer v

let use_pp_option () =
  Printf.fprintf stdout "The current setting is %a. \n there is only %a\n"
    (pp_option pp_int) (Some 3) (pp_option pp_int) None

let pp_expr ppf (exp : expression) =
  let open_paren prec op_prec out =
    if prec > op_prec then Printf.fprintf out "%s" "("
  in
  let close_paren prec op_prec out =
    if prec > op_prec then Printf.fprintf out "%s" ")"
  in
  let rec print prec ppf exp =
    match exp with
    | Const c -> Printf.fprintf ppf "%F" c
    | Var v -> Printf.fprintf ppf "%s" v
    | Sum (f, g) ->
        open_paren prec 0 ppf;
        Printf.fprintf ppf "%a + %a" (print 0) f (print 0) g;
        close_paren prec 0 ppf
    | Diff (f, g) ->
        open_paren prec 0 ppf;
        Printf.fprintf ppf "%a - %a" (print 0) f (print 0) g;
        close_paren prec 0 ppf
    | Prod (f, g) ->
        open_paren prec 2 ppf;
        Printf.fprintf ppf "%a * %a" (print 2) f (print 2) g;
        close_paren prec 2 ppf
    | Quot (f, g) ->
        open_paren prec 2 ppf;
        Printf.fprintf ppf "%a / %a" (print 2) f (print 2) g;
        close_paren prec 2 ppf
  in
  print 0 ppf exp

let f_string : _ format = "%i is an integer value, %F is a float, %S\n"
let use_f_string () = Printf.printf f_string 3 4.5 "string value"
let e = Sum (Prod (Const 2.0, Var "x"), Const 1.0)
