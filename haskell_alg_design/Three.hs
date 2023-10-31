module Three where


type SymList a = ([a], [a])

-- instance Show a => Show (SymList a) where
--     show = show . fromSL

nilSL = ([], [])

fromSL :: SymList a -> [a]
fromSL (xs, ys) = xs ++ reverse ys

headSL :: SymList a -> a
headSL (x:_, _) = x
headSL (_, x:_) = x

-- tailSL :: SymList a -> a
-- tailSL (x:xs, ys) = (xs, ys)
-- tailSL (xs, y:ys) = (xs, ys)

snocSL :: a -> SymList a -> SymList a
snocSL x ([], ys) = (ys, [x])
snocSL x (xs, ys) = (xs, x : ys)

lastSL :: SymList a -> a
lastSL (xs, []) = head xs
lastSL (_, ys) = head ys

consSL :: a -> SymList a -> SymList a
consSL x (xs, []) = ([x], xs)
consSL x (xs, ys) = (x : xs, ys)

tailSL :: SymList a -> SymList a
tailSL ([], [x]) = nilSL
tailSL ([x], ys) = reverse <$> splitAt (length ys `div` 2) ys
tailSL (xs, ys) = (tail xs, ys)

