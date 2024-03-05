{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}

module FirstClassFamilies where

import Data.Kind

-- fst :: (a, b) -> a Defunctionalization
data Fst a b = Fst (a, b)

class Eval l t | l -> t where
  eval :: l -> t

instance Eval (Fst a b) b where
  eval :: Fst a b -> b
  eval (Fst (a, b)) = b

-- listToMaybe :: [a] -> Maybe a
data ListToMaybe a = ListToMaybe [a]

instance Eval (ListToMaybe a) (Maybe a) where
  eval :: ListToMaybe a -> Maybe a
  eval (ListToMaybe (x:_)) = Just x
  eval (ListToMaybe []) = Nothing

data MapList dfb a = MapList (a -> dfb) [a]

instance Eval dfb dft => Eval (MapList dfb a) [dft] where
  eval (MapList f []) = []
  eval (MapList f (x : xs)) = eval (f x) : eval (MapList f xs)

type Exp a = a -> Type

type family EvalT (e :: Exp a) :: a

data Snd :: (a, b) -> Exp b
type instance EvalT (Snd '(a, b)) = b

data Const :: a -> b -> Exp a
type instance EvalT (Const a _) = a

data FromMaybe :: a -> Maybe a -> Exp a
type instance EvalT (FromMaybe _1 ('Just a)) = a
type instance EvalT (FromMaybe a 'Nothing) = a

data ListToMaybeD :: [a] -> Exp (Maybe a)
type instance EvalT (ListToMaybeD  '[]) = 'Nothing
type instance EvalT (ListToMaybeD (t ': ts)) = 'Just t

data MapListD :: (a -> Exp b) -> [a] -> Exp [b]
type instance EvalT (MapListD f '[]) = '[]
type instance EvalT (MapListD f (t ': ts)) =  EvalT (f t) ': EvalT (MapListD f ts)

data FoldR :: (a -> b -> Exp b) -> b -> [a] -> Exp b
type instance EvalT (FoldR f b '[]) = b
type instance EvalT (FoldR f b (t ': ts)) = EvalT (f t (EvalT (FoldR f b ts)))

data Pure :: a -> Exp a
type instance EvalT (Pure x) = x

data (=<<)
     :: (a -> Exp b)
     -> Exp a
     -> Exp b
type instance EvalT (f =<< expa) = EvalT (f (EvalT expa))

data (<=<)
     :: (b -> Exp c)
     -> (a -> Exp b)
     -> a -> Exp c
type instance EvalT ((f <=< g) a) = EvalT (f (EvalT (g a)))

data MkCTuple :: Constraint -> Constraint -> Exp Constraint
type instance EvalT (MkCTuple a b) = (a, b)

data Collapse :: [Constraint] -> Exp Constraint
type instance EvalT (Collapse ts) = EvalT (FoldR MkCTuple (() :: Constraint) ts)
-- type instance EvalT (Collapse '[]) = 
--   (() :: Constraint)
-- type instance EvalT (Collapse (t ': ts)) =
--   (t, EvalT (Collapse ts))

data Pure1 :: (a -> b) -> a -> Exp b
type instance EvalT (Pure1 f x) = f x

type All (c :: k -> Constraint) (ts :: [k]) = Collapse =<< MapListD (Pure1 c) ts

data Map :: (a -> Exp b) -> f a -> Exp (f b)

type instance EvalT (Map f '(t, a)) = '(t, EvalT (f a))

data Mappend :: a -> a -> Exp a 

type instance EvalT (Mappend '() '()) = '()

type instance EvalT (Mappend (a :: Constraint) (b :: Constraint)) = (a, b)

-- type application is explicit
data Mempty :: k -> Exp k
type instance EvalT (Mempty (c :: Constraint)) = (() :: Constraint)
