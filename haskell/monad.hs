import Control.Monad (join)

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
