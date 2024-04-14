import Data.Monoid
import Test.QuickCheck

data Option a =
    None
  | Some a
  deriving (Eq, Show)

instance (Semigroup a) => Semigroup (Option a) where
  (<>) (Some x) (Some y) = (Some (x <> y))
  (<>) None x = x
  (<>) x None = x
  

instance (Monoid a) => Monoid (Option a) where
  mempty = None

data Two a b = Two a b deriving (Eq, Show)

type TwoAssoc = Two (Sum Int) (Sum Int) -> Two (Sum Int) (Sum Int) -> Two (Sum Int) (Sum Int)-> Bool

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (Two a b) <> (Two c d) = Two (a <> c) (b <> d)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where 
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

twoGen :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
twoGen = do
  a <- arbitrary
  b <- arbitrary
  return (Two a b)

newtype First' a =
  First' {getFirst' :: Option a}
  deriving (Eq, Show)

instance Semigroup (First' a) where
  x <> (First' None) = x
  (First' None) <> x = x
  x <> (First' (Some _)) = x

instance Monoid (First' a) where
  mempty = First' None

data Combine a b = 
  Combine (a -> b)

instance Semigroup b => Semigroup (Combine a b) where
  (Combine f) <> (Combine g) = Combine (\x -> (f x) <> (g x))

instance (Monoid a, Monoid b) => Monoid (Combine a b) where
  mappend = (<>)
  mempty = Comp id 
  

  

type Verb = String
type Adjective = String
type Adverb = String
type Noun = String
type Exclamation = String



madlibbin :: Exclamation -> Adverb -> Noun -> Adjective -> String
madlibbin e adv n adj = 
  mconcat [
    e,
    "! he said ",
    adv,
    " as he jumped into his car ",
    n,
    " and drove of with hi ",
    adj,
    " wife."
  ]

threeAssoc :: (Eq a) => (a -> a -> a) -> a -> a -> a -> Bool
threeAssoc f a b c = f (f a b) c == f a (f b c)

semiAssoc :: (Eq s, Semigroup s) => s -> s -> s -> Bool
semiAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)



