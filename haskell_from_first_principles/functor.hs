e :: IO Integer
e = 
  let 
    ioi = (readIO "1") :: IO Integer
    changed = (fmap read) $ fmap (("123" ++) . show) ioi :: IO Integer
  in
    fmap (*3) changed

newtype Identity a = Identity a deriving (Show)

instance Functor Identity where
  fmap f (Identity a) = Identity $ f a

data Pair a = Pair a a deriving (Show)

instance Functor Pair where
  fmap f (Pair a b) = (Pair (f a) (f b))

data Two a b = Two a b deriving Show

instance Functor (Two a) where
  fmap f (Two a b) = Two a $ f b

data Three a b c = Three a b c deriving Show

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b $ f c

data Possibly a  =
    LolNope
  | Yeppers a
  deriving (Eq, Show)

instance Functor Possibly where
  fmap _ LolNope = LolNope
  fmap f (Yeppers a) = Yeppers $ f a

data Sum a b =
    First a
  | Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
  fmap _ (First a) = First a
  fmap f (Second a) = Second $ f a

data Quant a b =
    Finance
  | Desk a
  | Bloor b

instance Functor (Quant a) where
  fmap _ Finance = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor $ f b

data K a b = K a

instance Functor (K a) where
  fmap _ (K a) = (K a)

newtype Flip f a b = Flip (f b a)

instance Functor (Flip K a) where
  fmap f (Flip (K a)) = Flip $ K $ f a

data EvilGoatConst a b = GoatConst b

instance Functor (EvilGoatConst a) where
  fmap f (GoatConst a) = GoatConst $ f a

data Parappa f g a =
  DaWrappa (f a) (g a)
  deriving Show

instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap f (DaWrappa a b) = DaWrappa (fmap f a) (fmap f b)

data IgnoreOne f g a b =
  IgnoringSomething (f a) (g b)

instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething a b) = IgnoringSomething a $ fmap f b

data Notorious g o a t =
  Notorious (g o) (g a) (g t)

instance (Functor g) => Functor (Notorious g o a) where
  fmap f (Notorious a b c) = Notorious a b $ fmap f c

