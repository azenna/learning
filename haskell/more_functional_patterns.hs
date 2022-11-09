
addOneIfOdd n = case odd n of
    True -> f n
    False -> n
    where f = \n -> n + 1

addFive = \x -> \y -> min x y + 5

mflip f x y = f y x