{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DeriveAnyClass #-}

import GHC.Generics

import Data.Proxy

class GEq a where
  geq :: a x -> a x -> Bool

instance GEq U1 where
  geq U1 U1 = True

instance GEq V1 where
  geq _ _ = True

instance Eq a => GEq (K1 _1 a) where
  geq (K1 a) (K1 b) = a == b

instance (GEq a, GEq b) => GEq (a :+: b) where
  geq (L1 a) (L1 b) = geq a b
  geq (R1 a) (R1 b) = geq a b
  geq _ _ = False

instance (GEq a, GEq b) => GEq (a :*: b) where
  geq (a :*: b) (a1 :*: b1) = geq a a1 && geq b b1

data Foo a b c
  = F0
  | F1 a
  | F2 b c
  deriving (Generic)

instance (Eq a, Eq b, Eq c) => Eq (Foo a b c) where
  (==) = genericEq

genericEq :: (Generic a, GEq (Rep a)) => a -> a -> Bool
genericEq a b = geq (from a) (from b)

genericOrd :: (Generic a, GOrd (Rep a)) => a -> a -> Ordering
genericOrd a b = gcmp (from a) (from b)

instance GEq a => GEq (M1 _x _y a) where
  geq (M1 a) (M1 a1) = geq a a1

class GOrd a where
  gcmp :: a x -> a x -> Ordering

instance GOrd U1 where
  gcmp U1 U1 = EQ

instance GOrd V1 where
  gcmp _ _ = EQ

instance Ord a => GOrd (K1 _1 a) where
  gcmp (K1 a) (K1 b) = compare a b

instance (GOrd a, GOrd b) => GOrd (a :+: b) where
  gcmp (L1 a) (L1 b) = gcmp a b
  gcmp (R1 a) (R1 b) = gcmp a b
  gcmp (L1 _) (R1 _) = LT
  gcmp (R1 _) (L1 _) = GT

instance (GOrd a, GOrd b) => GOrd (a :*: b) where
  gcmp (a :*: b) (a1 :*: b1) = compare (gcmp a a1) (gcmp b b1)

instance GOrd a => GOrd (M1 _x _y a) where
  gcmp (M1 a) (M1 a1) = gcmp a a1

instance (Ord a, Ord b, Ord c) => Ord (Foo a b c) where
  compare = genericOrd


exNihilo :: (Generic a, GExNihilo (Rep a)) => a -> Maybe a
exNihilo a = to <$> gexn (from a)

class GExNihilo a where
  gexn :: a x -> Maybe (a x)

instance GExNihilo U1 where
  gexn U1 = Just U1

instance GExNihilo V1 where
  gexn _ = Nothing

instance GExNihilo (K1 _1 a) where
  gexn _ = Nothing

instance (GExNihilo a, GExNihilo b) => GExNihilo (a :+: b) where
  gexn _ = Nothing

instance (GExNihilo a, GExNihilo b) => GExNihilo (a :*: b) where
  gexn _ = Nothing

instance GExNihilo a => GExNihilo (M1 _x _y a) where
  gexn (M1 a) = M1 <$> gexn a

class MyEq a where
  eq :: a -> a -> Bool
  default eq
    :: (Generic a, GEq (Rep a))
    => a
    -> a
    -> Bool
  eq a b = geq (from a) (from b)

data Foo2 a b c = Foo2 a | Fool2 b c deriving (Generic, MyEq)
