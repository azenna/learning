import Control.Monad (join)
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Control.Applicative

bind :: Monad m => (a -> m b) -> m a -> m b
bind = (join .) . fmap

twiceWhenEven xs = do
  x <- xs
  if even x
    then [x*x, x*x]
    else []

data Sum a b =
    First a
  | Second b

instance Functor (Sum a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second $ f b

instance Applicative (Sum a) where

  pure :: b -> Sum a b
  pure = Second
  
  (<*>) :: Sum a (b -> c) -> Sum a b -> Sum a c
  (<*>) (First f) (Second a) = First f
  (<*>) (Second f) (First a) = First a
  (<*>) (Second f) (Second a) = Second $ f a
  (<*>) (First f) (First a) = First a

instance Monad (Sum a) where

  return = pure
  
  (>>=) (First a) f = First a
  (>>=) (Second b) f = f b

data Nope a = Nope deriving (Eq, Show)

instance Functor Nope where
  fmap _ _ = Nope

instance Applicative Nope where
  pure _ = Nope
  (<*>) _ _ = Nope

instance Monad Nope where
  return = pure
  (>>=) _ _ = Nope

instance Arbitrary (Nope a) where
  arbitrary = return Nope

instance EqProp (Nope a) where
  (=-=) = eq

data PbtEither b a =
    LeftE a
  | RightE b
  deriving (Eq, Show)

instance (Eq b, Eq a) => EqProp (PbtEither b a) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (PbtEither b a) where
  arbitrary = 
    frequency [(1, LeftE <$> arbitrary), (1, RightE <$> arbitrary)]

instance Functor (PbtEither b) where
  
  fmap :: (a -> c) -> PbtEither b a -> PbtEither b c
  fmap f (LeftE a) = LeftE $ f a
  fmap _ (RightE a) = RightE a

instance Applicative (PbtEither b) where

  pure :: a -> PbtEither b a
  pure = LeftE
  
  (<*>) :: PbtEither b (a -> c) -> PbtEither b a -> PbtEither b c
  (<*>) (LeftE a) (LeftE b) = LeftE $ a b
  (<*>) (RightE a) _ = RightE a
  (<*>) _ (RightE a) = RightE a

instance Monad (PbtEither b) where

  return = pure

  (>>=) :: PbtEither b a -> (a -> PbtEither b c) -> PbtEither b c
  (>>=) (RightE a) _ = RightE a
  (>>=) (LeftE a) f = f a

newtype Ident a = Ident a deriving (Eq, Ord, Show)

instance Eq a => EqProp (Ident a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (Ident a) where
  arbitrary = Ident <$> arbitrary

instance Functor Ident where
  fmap f (Ident a) = Ident $ f a

instance Applicative Ident where
  pure = Ident

  (<*>) (Ident f) (Ident a) = Ident $ f a

instance Monad Ident where
  return = pure

  (>>=) (Ident a) f = f a

triggerIdent :: Ident (Int, String, Bool)
triggerIdent = undefined

data List a =
    Nil
  | Cons a (List a)
  deriving (Eq, Show)

instance Eq a => EqProp (List a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (List a) where
  arbitrary =
    frequency [(1, liftA2 Cons arbitrary arbitrary), (1, return Nil)]

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a l) = Cons (f a) $ fmap f l

instance Applicative List where
  
  pure = (flip Cons) Nil

  (<*>) Nil _ = Nil
  (<*>) _ Nil = Nil
  (<*>) (Cons f l) l2 = lAppend (f <$> l2) (l <*> l2)

instance Monad List where
  
  return = pure

  (>>=) (Cons a l) f = lAppend (f a) (l >>= f)
  (>>=) Nil _ = Nil

lAppend :: List a -> List a -> List a
lAppend Nil l2 = l2
lAppend (Cons a Nil) l2 = Cons a l2
lAppend (Cons a l) l2 = Cons a $ lAppend l l2

triggerList :: List (Int, String, Bool)
triggerList = undefined

j :: Monad m => m (m a) -> m a
j = flip (>>=) $ id

l1 :: Monad m => (a -> b) -> m a -> m b
l1 = fmap

l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
l2 f a b = (f <$> a) <*> b

a :: Monad m => m a -> m (a -> b) -> m b
a m f = f <*> m

meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] _ = return []
meh (a:as) f = fmap (:) (f a) <*> meh as f

flipType :: (Monad m) => [m a] -> m [a]
flipType = (flip meh) id


