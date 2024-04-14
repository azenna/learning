

data Tree a = Node (Tree a) a (Tree a) | Leaf a

makeNTree :: Monoid m => Int -> Tree m
makeNTree 0 = Leaf mempty
makeNTree n = Node side mempty side
  where side = makeNTree $ n - 1
