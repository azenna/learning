
one :: a -> a -> a
one x y = x

two :: a -> a -> a
two x y = y

three:: a -> b -> b
three a b = b
i :: a -> a
i a = a

c :: a -> b -> a
c a b = a

c'' :: b -> a -> b
c'' b a = b

r :: [a] -> [a]
r as = take 2 as

co :: (b -> c) -> (a -> b) -> a -> c
co bC aB a = bC $ aB a

a :: (a -> c) -> a -> a
a f x = x

a' :: (a -> b) -> a -> b
a' aB a = aB a

fstString :: [Char] -> [Char]
fstString x = x ++ " in the rain"

sndString :: [Char] -> [Char]
sndString x = x ++ " over the rainbow"

sing = if (not $ x > y) then fstString x else sndString y
    where x = "Sigin"
          y = "Somewhere"

f :: Int -> String
f = undefined

g :: String -> Char
g = undefined

h :: Int -> Char
h x = g $ f x

data A
data B
data C

q :: A -> B
q = undefined

w :: B -> C
w = undefined

e :: A -> C
e x = w $ q x

ac :: A -> C
ac = undefined

bc :: B -> C
bc = undefined

xform :: (A, B) -> (C, C)
xform (a, b) = (ac a, bc b)

munge :: (x -> y)
      -> (y -> (w, z))
      -> x
      -> w
munge f g x = fst $ g $ f x
main :: IO()
main = do
    print $ 1 + 2
    print 10
    print (negate (-1))
    print ((+) 0 blah)
    where blah = negate 1