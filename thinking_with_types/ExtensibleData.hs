{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
module ExtensibleData where

import GHC.OverloadedLabels

import Fcf.Class.Foldable 
import Fcf hiding (Any)
import Data.Kind
import GHC.TypeLits hiding (type (+))
import Data.Proxy
import Unsafe.Coerce
import qualified Data.Vector as V
import Control.Monad.Writer (All(getAll))

data OpenSum (f :: k -> Type) (ts :: [k]) where
  UnsafeOpenSum 
    :: Int
    -> f t
    -> OpenSum f ts

type FindElem (key :: k) (ts :: [k]) = 
  FromMaybe Stuck 
   =<< FindIndex (TyEq key) ts

type Member t ts = KnownNat (Eval (FindElem t ts))

findElem :: forall t ts. Member t ts => Int
findElem = fromIntegral . natVal $ Proxy @(Eval (FindElem t ts))

inj :: forall f t ts. Member t ts => f t -> OpenSum f ts
inj = UnsafeOpenSum (findElem @t @ts)

prj :: forall f t ts. Member t ts => OpenSum f ts -> Maybe (f t)
prj (UnsafeOpenSum i f) =
  if i == findElem @t @ts 
  then Just $ unsafeCoerce f
  else Nothing

decompose
  :: forall f t ts. OpenSum f (t ': ts)
  -> Either (f t) (OpenSum f ts)
decompose (UnsafeOpenSum 0 t) = Left $ unsafeCoerce t
decompose (UnsafeOpenSum n t) = Right $ UnsafeOpenSum (n - 1) t

weaken :: OpenSum f ts -> OpenSum f (x ': ts)
weaken (UnsafeOpenSum n t)  = UnsafeOpenSum (n + 1) t

match
 :: forall f ts b.
    (forall t. f t -> b)
 -> OpenSum f ts
 -> b
match f (UnsafeOpenSum _ t) = f t

data AnyZ (f :: k -> Type) where
  AnyZ :: f t -> AnyZ f

data OpenProduct (f :: k -> Type)
                 (ts :: [(Symbol, k)]) where
  OpenProduct :: V.Vector (AnyZ f) -> OpenProduct f ts

nil :: OpenProduct f '[]
nil = OpenProduct V.empty

data Key (key :: Symbol) = Key

instance (key ~ key') => IsLabel key (Key key') where
  fromLabel = Key

insert
  :: Eval (UniqueKey key ts) ~ 'True
  => Key key
  -> f t
  -> OpenProduct f ts
  -> OpenProduct f ('(key, t) ': ts)
insert _ x (OpenProduct vec) = OpenProduct $ V.cons (AnyZ x) vec

type UniqueKey (key :: k) (ts :: [(k, t)]) = Null =<< Filter (TyEq key <=< Fst) ts

type FindElemP (key :: Symbol) (ts :: [(Symbol, k)]) = 
  Eval (FromMaybe Stuck 
   =<< FindIndex (TyEq key <=< Fst) ts)

findElemP :: forall key ts. KnownNat (FindElemP key ts) => Int
findElemP = fromIntegral . natVal $ Proxy @(FindElemP key ts)

type LookupType (key :: k) (ts :: [(k, t)]) =
  FromMaybe Stuck =<< Lookup key ts

get 
  :: forall key ts f
   . KnownNat (FindElemP key ts)
   => Key key
   -> OpenProduct f ts
   -> f (Eval (LookupType key ts))
get _ (OpenProduct v) =
  unAny $ V.unsafeIndex v $ findElemP @key @ts
  where unAny (AnyZ a) = unsafeCoerce a

type UpdateElem (key :: Symbol) (t :: k) (ts :: [(Symbol, k)]) =
  SetIndex (FindElemP key ts) '(key, t) ts

update
  :: forall key ts t f
   . KnownNat (FindElemP key ts)
  => Key key
  -> f t
  -> OpenProduct f ts
  -> OpenProduct f (Eval (UpdateElem key t ts))
update _ ft (OpenProduct v) = 
  OpenProduct $ v V.// [(findElemP @key @ts, AnyZ ft)]

type DeleteElem (key :: k) (ts :: [(k, t)]) =
  Eval (Filter (Not <=< TyEq k <=< Fst) ts)

deleteElem
  :: forall key ts f
   . KnownNat (FindElemP key ts)
  => Key key
  -> OpenProduct f ts
  -> OpenProduct f (DeleteElem key ts)
deleteElem _ (OpenProduct vec) = 
  OpenProduct $ V.ifilter (\i _ -> i /= findElemP @key @ts) vec

class MKnownNat (mn :: Maybe n) where
  mKnownNat :: proxy mn -> Maybe Int

instance KnownNat n => MKnownNat ('Just n) where
  mKnownNat _ = Just $ fromIntegral $ natVal (Proxy @n)

instance MKnownNat Nothing where
  mKnownNat _ = Nothing


type UpsertElem (key :: k) (x :: t) (ts :: [(k, t)]) =
   (If (Eval (Any (TyEq key <=< Fst) ts))
      ts
      ('(key, x) ': ts))

type MFindElemP (key :: Symbol) (ts :: [(Symbol, k)]) = 
  Eval (FindIndex (TyEq key <=< Fst) ts)

upsert
  :: forall key ts f t
   . (MKnownNat (MFindElemP key ts))
  => Key key
  -> f t
  -> OpenProduct f ts
  -> OpenProduct f (UpsertElem key t ts)
upsert key ft (OpenProduct v) = case mKnownNat (Proxy @(MFindElemP key ts)) of
  Just i -> OpenProduct $ v V.// [(i, AnyZ ft)]
  Nothing -> OpenProduct $ V.cons (AnyZ ft) v

