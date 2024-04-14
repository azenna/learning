module Two where

tails' :: [a] -> [[a]]
tails' = (take . length) <*> iterate (drop 1)
