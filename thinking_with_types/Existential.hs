{-# LANGUAGE  GADTs #-}
{-# LANGUAGE  RankNTypes #-}
{-# LANGUAGE  ScopedTypeVariables #-}
{-# LANGUAGE  TypeApplications #-}
module Existenetial where

import Data.Typeable
import Control.Applicative.Alternative

data Any where
  Any :: a -> Any

elimAny :: (forall a. a -> r) -> Any -> r
elimAny f (Any a) = f a

data HasShow where
  HasShow :: Show t => t -> HasShow

elimHasShow :: (forall a. Show a => a -> r) -> HasShow -> r
elimHasShow f (HasShow a) = f a

-- instance Show HasShow where
--   show (HasShow a) = show a
--
instance Show HasShow where
  show = elimHasShow show

data Dynamic where
  Dynamic :: Typeable a => a -> Dynamic

elimDynamic :: (forall a. Typeable a => a ->  r) -> Dynamic -> r
elimDynamic f (Dynamic a) = f a

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
liftD2 d1 d2 f = fmap Dynamic $
  f
  <$> fromDynamic @a d1
  <*> fromDynamic @b d2

pyPlus :: Dynamic -> Dynamic -> Dynamic
pyPlus a b = fromMaybe (error "Types not supported by pyPlus") $ asum
 [ liftD2 @Int @Int a b (+)
 , liftD2 @String @String a b (++)
 , liftD2 @Int @String a b $ \a b -> show a ++ b
 , liftD2 @String @Int a b $ \a b -> b ++ show a ]
