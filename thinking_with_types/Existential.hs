{-# LANGUAGE  GADTs #-}
{-# LANGUAGE  RankNTypes #-}
{-# LANGUAGE  ScopedTypeVariables #-}
{-# LANGUAGE  TypeApplications #-}
{-# LANGUAGE  UndecidableInstances #-}
module Existenetial where

import Data.Typeable
import Data.Kind
import Data.Foldable
import Data.Maybe
import Data.IORef
import System.IO.Unsafe

data Any where
  Any :: a -> Any

elimAny :: (forall a. a -> r) -> Any -> r
elimAny f (Any a) = f a

data Has (c :: Type -> Constraint) where
  Has :: c a => a -> Has c

-- data HasShow where
--   HasShow :: Show t => t -> HasShow
type HasShow = Has Show

elimHasShow :: (forall a. Show a => a -> r) -> HasShow -> r
elimHasShow f (Has a) = f a

-- instance Show HasShow where
--   show (HasShow a) = show a
--
-- instance Show HasShow where
--   show = elimHasShow show

-- data Dynamic where
--   Dynamic :: Typeable a => a -> Dynamic

type Dynamic = Has Typeable

elimDynamic :: (forall a. Typeable a => a ->  r) -> Dynamic -> r
elimDynamic f (Has a) = f a

fromDynamic :: Typeable a => Dynamic -> Maybe a
fromDynamic = elimDynamic cast

liftD2
  :: forall a b r.
    ( Typeable a
    , Typeable b
    , Typeable r
    )
    => Dynamic
    -> Dynamic
    -> (a -> b -> r)
    -> Maybe Dynamic

-- liftD2 d1 d2 f = fmap Dynamic $
--   f
--   <$> fromDynamic @a d1
--   <*> fromDynamic @b d2

liftD2 d1 d2 f = fmap Has $
  f
  <$> fromDynamic @a d1
  <*> fromDynamic @b d2

pyPlus :: Dynamic -> Dynamic -> Dynamic
pyPlus a b = fromMaybe (error "Types not supported by pyPlus") $ asum
 [ liftD2 @Int @Int a b (+)
 , liftD2 @String @String a b (++)
 , liftD2 @Int @String a b $ \a b -> show a ++ b
 , liftD2 @String @Int a b $ \a b -> a ++ show b ]

-- isMempty :: (Monoid a, Eq a) => a -> Bool
-- isMempty a = a == mempty

class (Monoid a, Eq a) => MonoidEq a
instance (Monoid a, Eq a) => MonoidEq a

newtype ST s a = ST { unsafeRunST :: a }

instance Functor (ST s) where
  fmap f (ST a) = seq a . ST $ f a

instance Applicative (ST s) where
  pure a = seq a (ST a)
  (ST f) <*> (ST a) = seq f . seq a . ST $ f a

instance Monad (ST s) where
  (ST a) >>= f = seq a (f a)

newtype STRef s a = STRef 
  { unSTRef :: IORef a }

newSTRef :: a -> ST s (STRef s a)
newSTRef = pure . STRef . unsafePerformIO . newIORef

readSTRef :: STRef s a -> ST s a
readSTRef = pure . unsafePerformIO . readIORef . unSTRef

writeSTRef :: STRef s a -> a -> ST s ()
writeSTRef st = pure . unsafePerformIO . writeIORef (unSTRef st)

modifySTRef :: STRef s a -> (a -> a) -> ST s ()
modifySTRef ref f = do
  a <- readSTRef ref
  writeSTRef ref (f a)

runST :: (forall s. ST s a) -> a
runST st = unsafeRunST st

safeExample :: ST s String
safeExample = do
  ref <- newSTRef "hello"
  modifySTRef ref (++ " world")
  readSTRef ref
