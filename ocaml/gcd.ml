let rec gcd a b = if b = 0 then a else gcd b (a mod b)

let main () =
  let a = int_of_string Sys.argv.(1) in
  let b = int_of_string Sys.argv.(2) in
  Printf.printf "%d\n" (gcd a b);
  exit 0
;;

main ()
