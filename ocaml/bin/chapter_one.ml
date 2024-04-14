open Core

type point2d = { x : float; y : float }

let magnitude (p : point2d) : float = sqrt ((p.x ** 2.) +. (p.y ** 2.))
let mag { x : float; y : float } : float = sqrt @@ ((x ** 2.) +. (y ** 2.))

let distance (p1 : point2d) (p2 : point2d) : float =
  magnitude { x = p2.x -. p1.x; y = p2.y -. p1.y }

let rec fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)
