{-# LANGUAGE DataKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE TypeFamilies #-}
module TypeError where

import GHC.TypeLits
import Data.Kind
import Fcf
import ExtensibleData
import Data.Vector qualified as V
import Data.Proxy

instance 
  ( TypeError 
    ( Text "Attempting to show a function of type `"
    :<>: ShowType (a -> b)
    :<>: Text "'"
    :$$: Text "Did you forget to apply an argument?"
    )
  ) => Show (a -> b) where
  show = undefined

type family PrettyPrintGo (ks :: [k]) where
  PrettyPrintGo '[] = 'Text ""
  PrettyPrintGo (t ': ts) = 'ShowType t ':<>: 'Text ",\n" ':<>: PrettyPrintGo ts

type family PrettyPrint (ks :: [k]) where
  PrettyPrint ts = 'Text "[ " ':<>: PrettyPrintGo ts ':<>: 'Text "\n]"

type family FriendlyFindElem (f :: k -> Type) (t :: k) (ts :: [k]) where
  FriendlyFindElem f t ts = 
    FromMaybe
      ( TypeError 
        ( 'Text "Attempted to call `friendlyPrj' to produce a `"
        ':<>: 'ShowType (f t)
        ':<>: 'Text "'."
        ':$$: 'Text "But the OpenSum can only contain one of:"
        ':$$: 'Text "  "
        ':<>: PrettyPrint ts
        )
      ) =<< FindIndex (TyEq t) ts

type family RequireUniqueKey 
  (res :: Bool) 
  (key :: Symbol) 
  (t :: k) 
  (ts :: [(Symbol, k)]) :: Constraint where
  RequireUniqueKey 'True key t ts = ()
  RequireUniqueKey 'False key t ts = 
    ( TypeError 
      ( 'Text "Attempting to add a field named `"
        ':<>: 'Text key
        ':<>: 'Text "' with type "
        ':<>: 'ShowType t
        ':$$: 'Text "But the OpenProduct already has a field `"
        ':<>: 'Text key
        ':<>: 'Text "' with type "
        ':<>: 'ShowType (LookupType key ts)
        ':$$: 'Text "Consider using 'update` "
        ':<>: 'Text "instead of `insert'."
      )
    ) 

type FriendlyFindElemP (verb :: Symbol) (key :: Symbol) (f :: k -> Type) (t :: k) (ts :: [(Symbol, k)]) = 
  Eval (FromMaybe
  ( TypeError 
        ( 'Text "Attempted to `"
        ':<>: 'ShowType verb
        ':<>: 'Text "' type `"
        ':<>: 'ShowType (f t)
        ':<>: 'Text "' at key `"
        ':<>: 'ShowType key
        ':$$: 'Text "But the OpenProduct does not contain key '"
        ':<>: 'ShowType key
        ':<>: 'Text "' in `"
        ':<>: PrettyPrint ts
        )
  )
  =<< FindIndex (TyEq key <=< Fst) ts)

friendlyFindElemP :: forall verb key f t ts. KnownNat (FriendlyFindElemP verb key f t ts) => Int
friendlyFindElemP = fromIntegral . natVal $ Proxy @(FriendlyFindElemP verb key f t ts)

friendlyUpdate
  :: forall key f t ts
   . KnownNat (FriendlyFindElemP "update" key f t ts)
  => Key key
  -> f t
  -> OpenProduct f ts
  -> OpenProduct f (Eval (UpdateElem key t ts))
friendlyUpdate _ ft (OpenProduct v) = 
  OpenProduct $ v V.// [(friendlyFindElemP @"update" @key @f @t @ts, AnyZ ft)]

friendlyDeleteElem
  :: forall key f t ts
   . KnownNat (FriendlyFindElemP "delete" key f t ts)
  => Key key
  -> OpenProduct f ts
  -> OpenProduct f (DeleteElem key ts)
friendlyDeleteElem _ (OpenProduct vec) = 
  OpenProduct $ V.ifilter (\i _ -> i /= friendlyFindElemP @"delete" @key @f @t @ts) vec

type family FriendlyUpdateElem (key :: Symbol) (f :: k -> Type) (t :: k) (ts :: [(Symbol, k)]) where
  FriendlyUpdateElem key f t ts = SetIndex (FriendlyFindElemP "update" key f t ts) '(key, t) ts

-- foo :: TypeError ('Text "test") => a -> a
-- foo = id

-- type family HelpfulDelete
--
