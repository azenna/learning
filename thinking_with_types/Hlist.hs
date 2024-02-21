{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

import Data.Kind (Constraint, Type)

data HList (ts :: [*]) where
  HNil :: HList '[]
  (:#) :: t -> HList ts -> HList (t ': ts)

infixr 5 :#


type family All (c :: Type -> Constraint)
                (ts :: [Type]) where
  All c (t ': ts) = (c t, All c ts)
  All c '[] = ()

-- instance Eq (HList '[]) where
--   HNil == HNil = True
--
-- instance (Eq t, Eq (HList ts)) => Eq (HList (t ': ts)) where
--   (a :# as) == (b :# bs) = a == b && as == bs

instance All Eq ts => Eq (HList ts) where
   HNil == HNil = True
   (a :# as) == (b :# bs) = a == b && as == bs

-- instance Ord (HList '[]) where
--   compare HNil HNil = EQ

instance (All Ord ts, All Eq ts) => Ord (HList ts) where
   compare HNil HNil = EQ
   compare (a :# as) (b :# bs) = compare a b <> compare as bs
-- instance (Ord t, Ord (HList ts)) => Ord (HList (t ': ts)) where
--   compare (a :# as) (b :# bs) = compare a b <> compare as bs

-- instance Show (HList '[]) where
--   show HNil = "[]"
--
-- instance (Show t, Show (HList ts)) => Show (HList (t ': ts)) where
--   show (t :# ts) = show t <> " " <> show ts

instance All Show ts => Show (HList ts) where
  show HNil = "[]"
  show (t :# ts) = show t <> " " <> show ts

testHList :: HList '[ Int, String, Maybe Int, Either Int () ]
testHList = 1 :# "hello" :# Nothing :# Left 3 :# HNil

