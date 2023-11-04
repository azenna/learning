module Three where

import Data.List
import Data.Tuple

type SymList a = ([a], [a])

nilSL = ([], [])

mySL = ([1, 2, 3, 4], [10, 9, 8, 7, 6, 5])

showSL (xs, ys) = show $ xs ++ reverse ys

fromSL :: SymList a -> [a]
fromSL (xs, ys) = xs ++ reverse ys

headSL :: SymList a -> a
headSL (x:_, _) = x
headSL (_, x:_) = x

snocSL :: a -> SymList a -> SymList a
snocSL x ([], ys) = (ys, [x])
snocSL x (xs, ys) = (xs, x : ys)

lastSL :: SymList a -> a
lastSL (xs, []) = head xs
lastSL (_, ys) = head ys

consSL :: a -> SymList a -> SymList a
consSL x (xs, []) = ([x], xs)
consSL x (xs, ys) = (x : xs, ys)

tailSL :: SymList a -> SymList a
tailSL ([], [x]) = nilSL
tailSL ([x], ys) = go $ splitAt (length ys `div` 2) ys
  where go (a, b) = (reverse b, a)
tailSL (xs, ys) = (tail xs, ys)

lengthSL :: SymList a -> Int
lengthSL (xs, ys) = length xs + length ys

nullSL :: SymList a -> Bool
nullSL ([], []) = True
nullSL (_, _) = False

singleSL :: SymList a -> Bool
singleSL ([x], []) = True
singleSL ([], [x]) = True
singleSL (_, _) = False

initSL :: SymList a -> SymList a
initSL ([x], []) = nilSL
initSL (xs, [y]) = reverse <$> splitAt (length xs `div` 2) xs
initSL (xs, ys) = (xs, tail ys)

dropWhileSL :: Eq a => (a -> Bool) -> SymList a -> SymList a
dropWhileSL p xs
  | nullSL xs = nilSL
  | p (headSL xs) = (dropWhileSL p (tailSL xs))
  | otherwise = xs

initsSL :: SymList a -> SymList (SymList a)
initsSL xs
  | nullSL xs = snocSL xs nilSL
  | otherwise = snocSL xs (initsSL (initSL xs))

data Tree a = Leaf a | Node Int (Tree a) (Tree a) deriving Show

size :: Tree a -> Int
size (Leaf _) = 1
size (Node x _ _) = x

l1 = Leaf 1
l2 = Leaf 2
l3 = Leaf 3
l4 = Leaf 4

n1 = node l1 l2
n2 = node l3 l4
n3 = node n1 n2

node :: Tree a -> Tree a -> Tree a
node t u = Node (size t + size u) t u

-- fromT :: Tree a -> [a]
-- fromT (Leaf x) = [x]
-- fromT (Node _ t u) = fromT t ++ fromT u

fromT :: Tree a -> [a]
fromT t = go t []
    where go (Leaf x) acc = x : acc
          go (Node _ t u) acc = (go t (go u acc))

fromTs :: [Tree a] -> [a]
fromTs [] = []
fromTs (Leaf t : ts) = t : fromTs ts
fromTs (Node _ t u : ts) = fromTs (t:u:ts)


fetchT :: Int -> Tree a -> a
fetchT 0 (Leaf x) = x
fetchT k (Node n t u)
  | k < m = fetchT k t
  | otherwise = fetchT (k - m) u
  where m = (div n 2)

data Digit a = Zero | One (Tree a)

type RAList a = [Digit a]

fromRA :: RAList a -> [a]
fromRA = (>>= go)
  where go Zero = []
        go (One t) = fromT t

fetchRA :: Int -> RAList a -> a
fetchRA k (Zero : xs) = fetchRA k xs
fetchRA k (One t : xs)
  | k < size t = fetchT k t
  | otherwise = fetchRA (k - size t) xs

consRA :: a -> RAList a -> RAList a
consRA x xs = go (Leaf x) xs
  where go t [] = [One t]
        go t (Zero : xs) = One t : xs
        go t (One u : xs) = Zero : go (node t u) xs 


unconsRA :: RAList a -> (a, RAList a)
unconsRA xs = (x, ys)
    where 
      (Leaf x, ys) = go xs
      go (One x : []) = (x, [])
      go (One x : xs) = (x, Zero : xs)
      go (Zero : xs) = (x, One y : ys)
          where (Node _ x y, ys) = go xs

inits' :: [a] -> [[a]]
inits' = scanl (\x y -> x ++ [y]) []
