import Data.Bifunctor

problem :: [Int] -> (Int, Int)
problem xs =  go xs
  where
    zipgo ((a, b), (c, d)) = (max a c, min b d)
    go [] = (0, 0)
    go (a:[]) = (a, a)
    go (a : b : []) = (max a b, min a b)
    go as = zipgo (bimap go go (splitAt (length as `div` 2) as)) 

main :: IO ()
main = print $ problem [1,3,1,4,5,6,1,9]

    
