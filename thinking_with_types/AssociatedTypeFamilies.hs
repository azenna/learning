{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module AssociatedTypeFamilies where

import   Data.Kind (Type)
import   Data.Monoid ((<>))
import   Data.Proxy (Proxy (..))
import   GHC.TypeLits


data (a :: k1) :<< (b :: k2)
infixr 5 :<<

class HasPrintf a where
  type Printf a :: Type
  format :: String
        -> Printf a

instance KnownSymbol text => HasPrintf (text :: Symbol) where
  type Printf text = String
  format s = s <> symbolVal (Proxy @text)

instance (KnownSymbol text, HasPrintf a) => HasPrintf ((text :: Symbol) :<< a) where
  type Printf (text :<< a) = Printf a
  format s = format @a (s <> symbolVal (Proxy @text))

instance (HasPrintf a, Show param) => HasPrintf ((param :: Type) :<< a) where
  type Printf (param :<< a) = param -> Printf a
  format s param = format @a (s <> show param)

instance {-# OVERLAPPING #-} HasPrintf a => HasPrintf (String :<< a) where
  type Printf (String :<< a) = String -> Printf a
  format s param = format @a (s <> param)

printf :: forall a. HasPrintf a => Printf a
printf = format @a ""
