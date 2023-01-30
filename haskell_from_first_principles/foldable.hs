import Data.Foldable
import Data.Monoid

sum' :: (Foldable t, Num a) => t a -> a
sum' = getSum . foldMap Sum

product' :: (Foldable t, Num a) => t a -> a
product' = getProduct . foldMap Product

elem' :: (Foldable t, Eq a) => a -> t a -> Bool
elem' a = getAny . foldMap (Any . (==a))


minimum' :: (Foldable t, Ord a) => t a -> Maybe a
minimum' = foldr go Nothing
  where
    go a b = case b of
      Nothing -> Just a
      (Just c) -> Just (min a c)

maximum' :: (Foldable t, Ord a) => t a -> Maybe a
maximum' = foldr go Nothing
  where
    go a b = case b of
      Nothing -> Just a
      (Just c) -> Just (max a c)

null' :: (Foldable t) => t a -> Bool
null' = foldr (\_ _ -> False) True

length' :: (Foldable t) => t a -> Int
length' = foldr (((+1) .) . (flip const)) 0

toList' :: (Foldable t) => t a -> [a]
toList' = foldMap (:[])

fold' :: (Foldable t, Monoid m) => t m -> m
fold' = foldr (<>) mempty

foldMap'' :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMap'' f = foldr (mappend . f) mempty

data Constant a b  = Constant b deriving (Eq, Show)

instance Foldable (Constant a) where
  foldr f i (Constant a) = f a i

data Two a b = Two a b deriving (Eq, Show)

instance Foldable (Two a) where
  foldr f i (Two _ b) = f b i

data Three a b c = Three a b c deriving (Eq, Show)

instance Foldable (Three a b) where
  foldr f i (Three _ _ c) = f c i

data Three' a b = Three' a b b deriving (Eq, Show)

instance Foldable (Three' a) where
  foldr f i (Three' _ a b) = f a (f b i)

data Four' a b = Four' a b b b deriving (Eq, Show)

instance Foldable (Four' a) where
  foldr f i (Four' _ a b c) = f a $ f b $ f c i

filterF :: (Applicative f,
            Foldable t,
            Monoid (f a))
        => (a -> Bool) -> t a -> f a
filterF pred = foldr (\a b -> if pred a then pure a <> b else b) mempty
