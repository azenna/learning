import Data.List (elemIndex)
import Control.Applicative
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

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

data List a =
    Nil
  | Cons a (List a)
  deriving (Eq, Show)

instance Semigroup (List a) where
  Nil <> Nil = Nil
  Nil <> (Cons a bs) = Cons a bs
  (Cons a bs) <> Nil = Cons a bs
  (Cons a bs) <> (Cons c ds) = Cons a (bs <> (Cons c ds))

instance Monoid (List a) where
  mempty = Nil
  mappend = (<>)

instance Functor List where

  fmap _ Nil = Nil
  fmap f (Cons x l) = Cons (f x) (fmap f l)

instance Applicative List where

  pure = (flip Cons) Nil
  
  (<*>) Nil _ = Nil
  (<*>) _ Nil = Nil
  (<*>) (Cons a bs) cs = fmap a cs <> (bs <*> cs)

instance Arbitrary a => Arbitrary (List a) where
  arbitrary = 
    frequency 
      [(1, return Nil), (2, liftA2 Cons arbitrary arbitrary)]

instance Eq a => EqProp (List a) where
  (=-=) = eq

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' x (Cons a bs) = Cons a $ take' (x - 1) bs

newtype ZipList' a = ZipList' (List a) deriving (Eq, Show)

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = eq xs' ys'
    where xs' = let (ZipList' l) = xs in take' 3000 l
          ys' = let (ZipList' l) = ys in take' 3000 l

instance Functor ZipList' where
  fmap f (ZipList' xs) = ZipList' $ fmap f xs

instance Applicative ZipList' where

  pure a = ZipList' as
    where as = Cons a as

  (<*>) (ZipList' (Cons a as)) (ZipList' (Cons c cs)) = 
    ZipList' $ (Cons (a c)) bs
    where (ZipList' bs) = (ZipList' as <*> ZipList' cs) 
  (<*>) (ZipList' Nil) _ = ZipList' Nil
  (<*>) _ (ZipList' Nil) = ZipList' Nil

instance Arbitrary a => Arbitrary (ZipList' a) where
  arbitrary = ZipList' <$> (arbitrary :: Gen (List a))
    
data V a b =
    F a
  | S b
  deriving (Eq, Show)

instance (Eq a, Eq b) => EqProp (V a b) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (V a b) where
  arbitrary = 
    frequency [(1, S <$> arbitrary), (1, F <$> arbitrary)]

instance Functor (V a) where
  fmap _ (F a) = F a
  fmap f (S b) = S $ f b

instance Monoid a =>
         Applicative (V a) where

  pure = S

  (<*>) (F a) (F b) = F $ a <> b
  (<*>) (F a) _ = F a
  (<*>) _ (F a) = F a
  (<*>) (S f) (S a) = S $ f a

data Three' a b = Three' a b b deriving (Eq, Show)

instance (Eq a, Eq b) => EqProp (Three' a b) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) =>
          Arbitrary (Three' a b) where
  arbitrary = liftA3 Three' arbitrary arbitrary arbitrary

instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

instance Monoid a => Applicative (Three' a) where
  pure a = Three' mempty a a

  (<*>) (Three' a b c) (Three' d e f) = Three' (a <> d) (b e) (c f)

stops = "pbtdkg"
vowels = "aeiou"

combos = liftA3 (,,) stops vowels stops
