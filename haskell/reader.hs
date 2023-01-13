import Control.Applicative
import Data.Char
import Data.Maybe
import Data.Monoid

boop :: Num a => a -> a
boop = (*2)

doop :: Num a => a -> a
doop = (+10)

bip :: Num a => a -> a
bip = boop . doop

bbop :: Num a => a -> a
bbop = (+) <$> boop <*> doop

duwop :: Num a => a -> a
duwop = liftA2 (+) boop doop

cap :: [Char] -> [Char]
cap = map toUpper

rev :: [Char] -> [Char]
rev = reverse

composed :: [Char] -> [Char]
composed = cap . rev

fmapped :: [Char] -> [Char]
fmapped = fmap cap rev

tupled :: [Char] -> ([Char], [Char])
tupled = (,) <$> cap <*> rev

tupled' :: [Char] -> ([Char], [Char])
tupled' = do
  a <- cap
  b <- rev
  return (a, b)

newtype Func a b = Func { runFunc :: a -> b }

instance Functor (Func a) where
  fmap :: (b -> c) -> Func a b -> Func a c
  fmap g (Func f) = Func $ g . f

instance Applicative (Func a) where
  pure :: b -> Func a b
  pure = Func . const
  
  (<*>) :: Func a (b -> c) -> Func a b -> Func a c
  (<*>) (Func f) (Func g) = Func $ \x -> f x (g x)


ask :: Func a a
ask = Func id

myLiftA2 :: Applicative f =>
            (a -> b -> c) ->
            f a -> f b -> f c
myLiftA2 f a b = f <$> a <*> b

asks :: (r -> a) -> Func r a
asks = Func

newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap :: (a -> b) -> Reader r a -> Reader r b
  fmap f (Reader g) = Reader $ (f . g)

instance Applicative (Reader r) where
  pure :: a -> Reader r a
  pure = Reader . const

  (<*>) :: Reader r (a -> b) -> Reader r a -> Reader r b
  (<*>) (Reader f) (Reader g) = Reader $ \r -> f r (g r)

instance Monad (Reader r) where
  
  return = pure

  (>>=) :: Reader r a -> (a -> Reader r b) -> Reader r b
  (>>=) (Reader f) g = Reader $ \r -> runReader (g (f r)) r
  
x = [1, 2, 3]
y = [4, 5, 6]
z = [7, 8, 9]

xs :: Maybe Integer
xs = lookup 3 $ zip x y

ys :: Maybe Integer
ys = lookup 6 $ zip y z

zs :: Maybe Integer
zs = lookup 4 $ zip x y

z' :: Integer -> Maybe Integer
z' = (flip lookup) (zip x z)

x1 :: Maybe (Integer, Integer)
x1 = liftA2 (,) xs ys

x2 :: Maybe (Integer, Integer)
x2 = liftA2 (,) ys zs

x3 :: Integer -> (Maybe Integer, Maybe Integer)
x3 = liftA2 (,) z' z'

summed :: Num c => (c, c) -> c
summed = uncurry (+)

bolt :: Integer -> Bool
bolt = liftA2 (&&) (>3) (<8)

sequA :: Integral a => a -> [Bool]
sequA = sequenceA [(>3), (<8), even]

s' = summed <$> x1

main :: IO ()
main = do
  print $ getAll $ foldMap All $ sequA 7
  print $ fromMaybe [] $ sequA <$> s'
  print $ fromMaybe False $ bolt <$> ys

