addOneIfOdd n = case odd n of
  True -> f n
  False -> n
  where
    f = \n -> n + 1

addFive = \x -> \y -> min x y + 5

mflip f x y = f y x

f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, _, c) (d, _, f) = ((a, d), (c, f))

functionC x y =
  case x > y of
    True -> x
    False -> y

ifEvenAdd2 n =
  case even n of
    True -> n + 2
    False -> n

nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0
