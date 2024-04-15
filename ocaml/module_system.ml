module type FIFO = sig
  type 'a queue = { front : 'a list; rear : 'a list }

  val empty : 'a queue
  val is_empty : 'a queue -> bool
  val add : 'a -> 'a queue -> 'a queue
  val top : 'a queue -> 'a
  val pop : 'a queue -> 'a queue

  exception Empty
end

module Fifo : FIFO = struct
  type 'a queue = { front : 'a list; rear : 'a list }

  let make front rear =
    match front with
    | [] -> { front = List.rev rear; rear = [] }
    | _ -> { front; rear }

  let empty = { front = []; rear = [] }
  let is_empty = function { front = []; _ } -> true | _ -> false
  let add x q = make q.front (x :: q.rear)

  exception Empty

  let top = function
    | { front = []; _ } -> raise Empty
    | { front = x :: _; _ } -> x

  let pop = function
    | { front = []; _ } -> raise Empty
    | { front = _ :: f; rear = r } -> make f r
end

module type FIFO_WITH_OPT = sig
  include FIFO

  val top_opt : 'a queue -> 'a option
  val pop_opt : 'a queue -> 'a queue option
end

module FifoOpt : FIFO_WITH_OPT = struct
  include Fifo

  let top_opt q = if is_empty q then None else Some (top q)
  let pop_opt q = if is_empty q then None else Some (pop q)
end

module Lifo = struct
  type 'a stack = { plates : 'a list }

  let make plates = { plates }
  let empty = { plates = [] }
  let is_empty = function { plates = [] } -> true | _ -> false
  let add p s = make (p :: s.plates)

  exception Empty

  let top = function { plates = [] } -> raise Empty | { plates = x :: _ } -> x

  let pop = function
    | { plates = [] } -> raise Empty
    | { plates = _ :: xs } -> make xs
end

module AbstractQueue : FIFO = Fifo

let use_fifo () =
  let open Fifo in
  add "hello" empty

let use_fifo2 () = Fifo.(add "hello" empty)

let at_most_one_element x =
  match x with Fifo.{ front = [] | [ _ ]; rear = [] } -> true | _ -> false

type comparison = Less | Equal | Greater

module type ORDERED_TYPE = sig
  type t

  val compare : t -> t -> comparison
end

module Set =
functor
  (Elt : ORDERED_TYPE)
  ->
  struct
    type item = Elt.t
    type set = item list

    let empty = []

    let rec add x s =
      match s with
      | [] -> [ x ]
      | hd :: tl -> (
          match Elt.compare x hd with
          | Less -> x :: s
          | Equal -> s
          | Greater -> hd :: add x tl)

    let rec member x s =
      match s with
      | [] -> false
      | hd :: tl -> (
          match Elt.compare x hd with
          | Less -> false
          | Equal -> true
          | Greater -> member x tl)
  end

module OrderedString = struct
  type t = string

  let compare x y = if x = y then Equal else if x < y then Less else Greater
end

module StringSet = Set (OrderedString)

module type SETFUNCTOR = functor (T : ORDERED_TYPE) -> sig
  type item = T.t
  type set

  val empty : set
  val add : item -> set -> set
  val member : item -> set -> bool
end

module AbstractSet : SETFUNCTOR = Set
module AbstractStringSet = AbstractSet (OrderedString)

module type SET = sig
  type item
  type set

  val empty : set
  val add : item -> set -> set
  val member : item -> set -> bool
end

module WrongSet : functor (Elt : ORDERED_TYPE) -> SET = Set
module WrongStringSet = WrongSet (OrderedString)

module AbstractSet2 : functor (Elt : ORDERED_TYPE) ->
  SET with type item = Elt.t =
  Set

module AbstractSet2StringSet = AbstractSet2 (OrderedString)

module NoCaseString = struct
  type t = string

  let compare s1 s2 =
    OrderedString.compare
      (String.lowercase_ascii s1)
      (String.lowercase_ascii s2)
end

module NoCaseStringSet = AbstractSet (NoCaseString)
