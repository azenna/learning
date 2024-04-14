import System.Random
import Control.Applicative (liftA3)
import Control.Monad (replicateM)
import Control.Monad.Trans.State

data Die =
    D1
  | D2
  | D3
  | D4
  | D5
  | D6
  deriving (Eq, Show, Enum, Bounded)


rollDie :: State StdGen Die
rollDie = 
  toEnum <$> state (randomR (0, 5))

rollDieThreeTimes :: State StdGen (Die, Die, Die)
rollDieThreeTimes = liftA3 (,,) rollDie rollDie rollDie

nDie :: Int -> State StdGen [Die]
nDie = (flip replicateM) rollDie

--tried to do something with laziness here but didn't work
--rollsToGetN :: Int -> State StdGen Int
--rollsToGetN n =
--    length
--  . takeWhile (<n)
--  . scanl (flip ((+) . fromEnum)) 0
--  . repeat 
--  <$> rollDie

rollsCountLogged :: Int -> StdGen -> (Int, [Int])
rollsCountLogged n sg = go 0 0 [] sg
  where
    go sum count dies gen
      | sum >= n = (count, dies)
      | otherwise =
          go (sum + die) (count + 1) (die : dies) nextGen
            where (die, nextGen) = randomR (1, 6) gen

newtype Moi s a = Moi { runMoi :: s -> (a, s) }

instance Functor (Moi s) where
  fmap :: (a -> b) -> Moi s a -> Moi s b
  fmap f (Moi g) = Moi $ \s -> 
    let (a, ns) = g s
    in (f a, ns)

instance Applicative (Moi s) where
  pure :: a -> Moi s a
  pure a = Moi $ \s -> (a, s)

  (<*>) ::    Moi s (a -> b)
           -> Moi s a
           -> Moi s b
  (<*>) (Moi f) (Moi g) =
    Moi $ \s -> let (ga, ns) = g s
                    (fab, fs) = f ns
                in (fab ga, fs)

instance Monad (Moi s) where
  return = pure

  (>>=) :: Moi s a -> (a -> Moi s b) -> Moi s b
  --convuluted tacit go brr
  (>>=) (Moi f) g = Moi $ (uncurry (runMoi . g)) . f

moiGet :: Moi s s
moiGet = Moi $ \s -> (s, s)

moiPut :: s -> Moi s ()
moiPut s = Moi $ \r -> ((), s)

moiExec :: Moi s a -> s -> s
moiExec (Moi sa) s = snd $ sa s

moiEval :: Moi s a -> s -> a
moiEval (Moi sa) = fst . sa

moiModify :: (s -> s) -> Moi s ()
moiModify f = Moi $ \s -> ((), f s)
    
