module ComposingTypes where

import Control.Applicative

newtype Compose f g a = 
  Compose { runCompose :: f (g a) }
  deriving (Eq, Show)

instance (Functor f, Functor g) => Functor (Compose f g) where
  
  fmap :: (a -> b) -> Compose f g a -> Compose f g b

  fmap f (Compose a) = Compose $ fmap (fmap f) a

instance (Applicative f, Applicative g) 
      => Applicative (Compose f g) where

  pure :: a -> Compose f g a
  pure a = Compose $ (pure . pure) a

  (<*>) :: Compose f g (a -> b)
        -> Compose f g a
        -> Compose f g b

  --this makes a lot of sense in retrospect
  (<*>) (Compose f) (Compose g) = Compose $
    liftA2 (<*>) f g

instance (Foldable f, Foldable g) =>
         Foldable (Compose f g) where
  
  foldMap :: (Monoid m) => (a -> m) -> Compose f g a -> m
  foldMap f (Compose a) = (foldMap . foldMap) f a

class Bifunctor p where
  {-# MINIMAL bimap | first, second #-}
  
  bimap :: (a -> b)
        -> (c -> d)
        -> p a c
        -> p b d

  bimap f g = first f . second g

  first :: (a -> b) -> p a c -> p b c
  first f = bimap f id

  second :: (b -> c) -> p a b -> p a c
  second = bimap id

data Deux a b = Deux a b deriving (Eq, Show)

instance Bifunctor Deux where
  
  first :: (a -> b) -> Deux a c -> Deux b c
  first f (Deux a b) = Deux (f a) b

  second :: (a -> b) -> Deux c a -> Deux c b
  second f (Deux a b) = Deux a (f b)

data Const' a b = Const' a deriving (Eq, Show)

instance Bifunctor Const' where
  
  bimap :: (a -> b) -> (c -> d) -> Const' a c -> Const' b d
  bimap f _ (Const' a) = Const' $ f a

data Drei a b c = Drei a b c deriving (Eq, Show)

instance Bifunctor (Drei a) where
  
  bimap :: (b -> d) -> (c -> e) -> Drei a b c -> Drei a d e
  bimap f g (Drei a b c) = Drei a (f b) (g c)

data Sum a b =
    First a
  | Second b 
  deriving (Eq, Show)

instance Bifunctor Sum where
  
  first :: (a -> b) -> Sum a c -> Sum b c
  first f (First a) = First $ f a
  first _ (Second a) = Second a

  second :: (a -> b) -> Sum c a -> Sum c b
  second f (Second a) = Second $ f a
  second _ (First a) = First a

newtype IdentityT f a =
  IdentityT { runIdentityT :: f a}

instance (Functor f) => Functor (IdentityT f) where
  fmap f (IdentityT fa) =
    IdentityT (fmap f fa)

instance (Applicative a) => Applicative (IdentityT a) where
  
  pure x = IdentityT (pure x)

  (<*>) (IdentityT f) (IdentityT a) = 
    IdentityT $ f <*> a

instance (Monad m) => Monad (IdentityT m) where
  
  return = pure

  (>>=) (IdentityT m) f = IdentityT $ m >>= runIdentityT . f


  


  
