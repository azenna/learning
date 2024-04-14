notThe :: String -> String
notThe "the" = "a"
notThe x = x

replaceThe :: String -> String
replaceThe = unwords . map notThe . words

lefts :: [Either a b] -> [a]
lefts = foldr f []
  where 
    f (Left x) y = x : y
    f _ y = y

myIterate :: (a -> a) -> a -> [a]
myIterate f i = i : myIterate f (f i)

myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f x =
  case f x of
    Just (y, z) -> y : myUnfoldr f z
    Nothing -> []

betterIterate f = myUnfoldr (\x -> Just (x, f x))

data BinaryTree a =
    Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)

treeTake 0 t = Leaf
treeTake _ Leaf = Leaf
treeTake n (Node left x right) = Node (treeTake (n - 1) left) x (treeTake (n - 1) right)

unfold ::
  (a -> Maybe (a, b, a))
  -> a
  -> BinaryTree b

unfold f x =
  case f x of
    Just (a, b, c) -> Node (unfold f a) b (unfold f c)
    Nothing -> Leaf

treeBuild :: Integer -> BinaryTree Integer
treeBuild n = treeTake n $ unfold (\x -> Just (x - 1, x , x + 1)) 0
