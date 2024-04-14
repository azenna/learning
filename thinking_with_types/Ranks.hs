module Ranks where
import Text.XHtml (base)

cont :: a -> (forall r. (a -> r) -> r)
cont a callback = callback a

runCont :: (forall r. (a -> r) -> r) -> a
runCont cont = cont id

newtype Cont a = Cont
  { unCont :: forall r. (a -> r) -> r
  }

instance Functor Cont where
  fmap f (Cont conta) = Cont $ \g -> conta (g . f)

-- a -> b
-- conta Cont (a -> r) -> r
-- res = Cont (b -> r) -> r

instance Applicative Cont where
  pure a = Cont $ \callback -> callback a
  (Cont contab) <*> (Cont conta) = Cont $ \g -> 
    contab (\ab -> conta (g . ab))

-- contab :: ((a -> b) -> r) -> r
-- conta :: (a -> r) -> r
-- res :: (b -> r) -> r
-- g :: b -> r

instance Monad Cont where
  -- cba :: (a -> r) -> r
  -- g :: a -> ((b -> r) -> r)
  -- (((b -> r) -> r) -> r) -> r
  -- (b -> r) -> r
  (Cont cba) >>= g = Cont $ \cbb -> cba (\a -> (unCont $ g a) cbb)

newtype ContT m a = ContT
  { unContT :: forall r. (m a -> r) -> r
  }
