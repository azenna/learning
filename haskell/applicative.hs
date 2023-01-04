import Data.List (elemIndex)
import Control.Applicative

t :: [(Int, Int)]
t = zip [1..3] [4..6]

y :: Maybe Int
y = lookup 3 t

z :: Maybe Int
z = lookup 2 t

tupled :: Maybe (Int, Int)
tupled = (,) <$> y <*> z

added :: Maybe Int
added = pure (+3) <*> y

x :: Maybe Int
x = elemIndex 3 [1..5]

a :: Maybe Int
a = elemIndex 4 [1..5]

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = max' <$> x <*> a

summed :: Maybe Int
summed = fmap sum $ (,) <$> y <*> z

newtype Identity a = Identity a
  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity $ f a

instance Applicative Identity where
  pure = Identity
  (<*>) (Identity f) (Identity a) = Identity $ f a

newtype Constant a b = 
  Constant a
  deriving (Eq, Ord, Show)

instance Functor (Constant a) where
  fmap _ (Constant a) = Constant a

instance Monoid a => Applicative (Constant a) where
  pure _ = Constant mempty
  (<*>) (Constant a) (Constant b) = Constant $ a <> b

