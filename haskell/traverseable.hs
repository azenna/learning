import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Data.Monoid
import Control.Applicative

newtype Identity a = Identity a
  deriving (Eq, Ord, Show)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = Identity <$> arbitrary

instance Eq a => EqProp (Identity a) where
  (=-=) = eq

instance Functor Identity where
  fmap :: (a -> b) -> Identity a -> Identity b
  fmap f (Identity a) = Identity $ f a

instance Foldable Identity where
  foldMap :: Monoid m => (a -> m) -> Identity a -> m
  foldMap f (Identity a) = f a

instance Traversable Identity where
  traverse :: Applicative f => 
              (a -> f b) -> Identity a -> f (Identity b)
  traverse f (Identity a) = Identity <$> f a

triggerId :: Identity (Maybe Int, Maybe String, Integer, Any)
triggerId = undefined

testId = quickBatch $ traversable triggerId

newtype Constant a b = Constant a
  deriving (Eq, Show)

instance Eq a => EqProp (Constant a b) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (Constant a b) where
  arbitrary = Constant <$> arbitrary

instance Functor (Constant a) where
  fmap :: (b -> c) -> Constant a b -> Constant a c
  fmap _ (Constant a) = (Constant a)

instance Foldable (Constant a) where
  foldr :: (b -> c -> c) -> c -> Constant a b -> c
  foldr _ i _ = i

instance Traversable (Constant a) where
  traverse :: Applicative f =>
              (b -> f c) -> Constant a b -> f (Constant a c)
  traverse f (Constant a) = pure (Constant a)

triggerConst :: 
  Constant (Maybe Int, Maybe String, Integer, Any)
           (Maybe Int, Maybe String, Integer, Any)
triggerConst = undefined

testConst = quickBatch $ traversable triggerConst

data Optional a =
    Nada
  | Yep a
  deriving (Eq, Show)

instance Eq a => EqProp (Optional a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (Optional a) where
  arbitrary = 
    frequency [(1, return Nada), (1, Yep <$> arbitrary)]

instance Functor Optional where
  fmap :: (a -> b) -> Optional a -> Optional b
  fmap _ Nada = Nada
  fmap f (Yep a) = Yep $ f a

instance Foldable Optional where
  foldMap :: Monoid m => (a -> m) -> Optional a -> m
  foldMap _ Nada = mempty
  foldMap f (Yep a) = f a

instance Traversable Optional where
  traverse :: Applicative f =>
              (a -> f b) -> Optional a -> f (Optional b)
  traverse _ Nada = pure Nada
  traverse f (Yep a) = Yep <$> f a

triggerOpt :: 
  Optional (Maybe Int, Maybe String, Integer, Any)
triggerOpt = undefined

testOpt = quickBatch $ traversable triggerOpt

data List a =
    Nil
  | Cons a (List a)
  deriving (Eq, Show)

instance Eq a => EqProp (List a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (List a) where
  arbitrary =
    frequency
      [(1, return Nil), (1, (Cons <$> arbitrary) <*> arbitrary)]

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a l) = Cons (f a) (fmap f l)

instance Foldable List where
  foldr :: (a -> b -> b) -> b -> List a -> b
  foldr _ i Nil = i
  foldr f i (Cons a l) = f a $ foldr f i l

instance Traversable List where
  traverse :: Applicative f =>
              (a -> f b) -> List a -> f (List b)
  traverse _ Nil = pure Nil
  traverse f (Cons a l) = liftA2 Cons (f a) (traverse f l)

triggerList :: 
  List (Maybe Int, Maybe String, Integer, Any)
triggerList = undefined

testList = quickBatch $ traversable triggerList

data Bigger a b = Bigger a b b b
  deriving (Eq, Show)

instance (Eq a, Eq b) => EqProp (Bigger a b) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (Bigger a b) where
  arbitrary = 
    liftA3 Bigger arbitrary arbitrary arbitrary <*> arbitrary

instance Functor (Bigger a) where
  fmap f (Bigger a b c d) = Bigger a (f b) (f c) (f d)

instance Foldable (Bigger a) where
  foldMap f (Bigger _ a b c) = f a <> f b <> f c

instance Traversable (Bigger a) where
  traverse f (Bigger a b c d) = liftA3 (Bigger a) (f b) (f c) (f d)

triggerBigger :: 
  Bigger (Maybe Int, Maybe String, Integer, Any)
         (Maybe Int, Maybe String, Integer, Any)
triggerBigger = undefined

testBigger = quickBatch $ traversable triggerBigger

{-# LANGUAGE FlexibleContexts #-}

data S n a = S (n a) a deriving (Eq, Show)

instance (Functor n,
          Arbitrary (n a),
          Arbitrary a) =>
          Arbitrary (S n a) where
  arbitrary = liftA2 S arbitrary arbitrary

instance (Applicative n,
          Testable (n Property),
          EqProp a) =>
          EqProp (S n a) where
  (S x y) =-= (S p q) =
        (property $ (=-=) <$> x <*> p)
    .&. (y =-= q)

instance Functor n => Functor (S n) where
  fmap f (S a b) = S (f <$> a) (f b)

instance Foldable n => Foldable (S n) where
  foldMap f (S a b) = foldMap f a <> f b

instance Traversable n => Traversable (S n) where
  traverse f (S a b) = liftA2 S (traverse f a) (f b)

sTrigger :: S [] (Maybe Int, Maybe String, Integer, Any)
sTrigger = undefined

sTest = quickBatch $ traversable sTrigger

data Tree a =
    Empty
  | Leaf a
  | Node (Tree a) a (Tree a)
  deriving (Eq, Show)

instance Eq a => EqProp (Tree a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary =
    frequency [(1, return Empty),
               (1, Leaf <$> arbitrary),
               (1, liftA3 Node arbitrary
                               arbitrary
                               arbitrary)]

--this was suprisingly easy
--probably could write a HOF that generalizes this patter of tree traversal
instance Functor Tree where
  fmap _ Empty = Empty
  fmap f (Leaf a) = Leaf $ f a
  fmap f (Node l a r) = Node (fmap f l) (f a) (fmap f r)

instance Foldable Tree where
  foldMap _ Empty = mempty
  foldMap f (Leaf a) = f a
  foldMap f (Node l a r) = (foldMap f l) <> f a <> (foldMap f r)

instance Traversable Tree where
  traverse _ Empty = pure Empty
  traverse f (Leaf a) = Leaf <$> f a
  traverse f (Node l a r) = 
    liftA3 Node (traverse f l) (f a) (traverse f r)

treeTrigger :: Tree (Maybe Int, Maybe String, Integer, Any)
treeTrigger = undefined

treeTest = quickBatch $ traversable treeTrigger
