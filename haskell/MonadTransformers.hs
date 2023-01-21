import Control.Applicative

newtype EitherT e m a =
  EitherT { runEitherT :: m (Either e a)}

instance Functor m => Functor (EitherT e m) where
  
  fmap :: (a -> b) -> EitherT e m a -> EitherT e m b
  fmap f (EitherT m) = EitherT $ (fmap . fmap) f m

instance Applicative m
      => Applicative (EitherT e m) where

  pure :: a -> EitherT e m a
  pure a = EitherT $ pure (Right a)

  (<*>) :: EitherT e m (a -> b)
        -> EitherT e m a
        -> EitherT e m b
  (<*>) (EitherT a) (EitherT b) = EitherT $ liftA2 (<*>) a b

instance Monad m => Monad (EitherT e m) where
  return = pure
  
  (>>=) :: EitherT e m a -> (a -> EitherT e m b) -> EitherT e m b
  (>>=) (EitherT m) f = EitherT $
    m >>= runEitherT . g

    where g (Left a) = EitherT $ return (Left a)
          g (Right a) = f a

swapEither :: Either a b -> Either b a
swapEither (Right a) = Left a
swapEither (Left a) = Right a

swapEitherT :: Functor m 
            => EitherT e m a
            -> EitherT a m e
swapEitherT (EitherT f) = EitherT $ fmap swapEither f

eitherT :: Monad m
        => (a -> m c)
        -> (b -> m c)
        -> EitherT a m b
        -> m c
eitherT f g (EitherT a) = a >>= either f g

newtype ReaderT r m a =
  ReaderT { runReaderT :: r -> m a }

instance Functor m => Functor (ReaderT r m) where
  fmap :: (a -> b) -> ReaderT r m a -> ReaderT r m b
  fmap f (ReaderT g) = ReaderT $ \r ->
    fmap f (g r)

instance Applicative m => Applicative (ReaderT r m) where
  
  pure :: a -> ReaderT r m a
  pure a = ReaderT $ const (pure a)

  (<*>) :: ReaderT r m (a -> b) 
        -> ReaderT r m a
        -> ReaderT r m b
  (<*>) (ReaderT f) (ReaderT g) = ReaderT $ \r ->
    (f r) <*> (g r)

instance Monad m => Monad (ReaderT r m) where
  
  return = pure

  (>>=) :: ReaderT r m a 
        -> (a -> ReaderT r m b) 
        -> ReaderT r m b
  (>>=) (ReaderT f) g = ReaderT $ \r ->
    (f r) >>= (flip $ runReaderT . g) r



