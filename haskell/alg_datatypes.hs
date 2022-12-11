import Data.Char as Char

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

instance TooMany (Int, String) where
  tooMany (n, _) = n > 42

data Os = Linux | Unix | Mac | Windows deriving (Eq, Show)

data Lang = Haskell | Agda | Idris | PureScript deriving (Eq, Show)

data Programmer = Programmer
  { os :: Os,
    lang :: Lang
  }
  deriving (Eq, Show)

allLang :: [Lang]
allLang = [Haskell, Agda, Idris, PureScript]

allOs = [Linux, Unix, Mac, Windows]

allProgrammer :: [Programmer]
allProgrammer = [Programmer {os = x, lang = y} | x <- allOs, y <- allLang]

data Quantum = Yes | No | Both

convert :: Quantum -> Bool
convert Yes = True
convert No = True
convert Both = True

convert2 :: Quantum -> Bool
convert2 Yes = True
convert2 No = True
convert2 Both = False

data BinaryTree a
  = Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Show, Ord, Eq)

exTree :: BinaryTree Int
exTree =
  Node
    (Node Leaf 9 Leaf)
    10
    (Node Leaf 11 Leaf)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' x Leaf = Node Leaf x Leaf
insert' x (Node left y right)
  | x == y = Node left y right
  | x > y = Node left y (insert' x right)
  | x < y = Node (insert' x left) y right

treeMap :: (a -> b) -> BinaryTree a -> BinaryTree b
treeMap _ Leaf = Leaf
treeMap f (Node left x right) =
  Node (treeMap f left) (f x) (treeMap f right)

treeList :: BinaryTree a -> [a]
treeList Leaf = []
treeList (Node left x right) =
  (treeList left) ++ (x : (treeList right))

foldTree ::
  (a -> b -> b) ->
  b ->
  BinaryTree a ->
  b
foldTree _ i Leaf = i
foldTree f i (Node left x right) =
  foldTree f (f x (foldTree f i left)) right

-- kinda shity approach but it works and uses @ syntax
isSubSeqOf :: (Eq a) => [a] -> [a] -> Bool
isSubSeqOf [] _ = True
isSubSeqOf s@(x : xs) (y : ys)
  | (length xs) > (length ys) = False
  | x == y = (isSubSeqOf xs ys) || (isSubSeqOf s ys)
  | otherwise = isSubSeqOf s ys

capitalize :: String -> String
capitalize (x : xs) = Char.toUpper x : xs

capitalizeWords :: String -> [(String, String)]
capitalizeWords = map (\x -> (x, capitalize x)) . words

separate :: (Char -> Bool) -> String -> [String]
separate p s =
  case dropWhile p s of
    "" -> []
    s' -> w : separate p s''
      where
        (w, s'') = break p s'

join :: String -> [String] -> String
join _ (x : []) = x
join s (x : xs) = x ++ s ++ join s xs

capitalizeParagraph :: String -> String
capitalizeParagraph = join ". " . map capitalize . map (dropWhile (== ' ')) . separate (== '.')
