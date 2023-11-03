import Data.Char
import Control.Monad
import Data.Foldable

type Set = (Int, [String])

showSet :: Set -> IO ()
showSet (a, as) = do
  putStrLn $ "SET " <> show a
  traverse_ putStrLn as

transform :: Set -> Set
transform (a, xs) = (a, ys ++ reverse zs)
  where 
    as = zip [0..] xs
    ys = map snd $ filter (even . fst) as
    zs = map snd $ filter (odd . fst) as
  

readStuff = do
  x <- getLine
  case (read x :: Int) of
    0 -> pure []
    y -> do 
      z <- (,) y <$> replicateM y getLine
      a <- readStuff
      pure $ z : a


main = do
    x <- readStuff
    traverse_ (\(i, (_, b)) -> showSet $ transform (i, b)) (zip [1..] x)


