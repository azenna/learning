import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Data.Monoid

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

