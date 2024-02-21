module Covariant where

newtype MyCovariant a = MyCovariant ((a -> Int) -> Int)

instance Functor MyCovariant where
  fmap f (MyCovariant g) = MyCovariant $ \h -> g (h . f)
