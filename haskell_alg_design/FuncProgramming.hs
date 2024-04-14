module One where

wrap :: a -> [a]
wrap = pure

unwrap :: [a] -> a
unwrap (x:[]) = x

single :: [a] -> Bool
single (x:[]) = True
single _ = False

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) mempty 

map' :: (a -> b) -> [a] -> [b]
map' = flip foldr mempty . (.) (:)

filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldr (\x y -> if f x then x : y else y) []

filterFold :: (a -> Bool) -> (a -> b -> b) -> b -> [a] -> b
filterFold p f = foldr (\x y -> if p x then f x y else y)

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' p = foldr (\x y -> if p x then x : y else []) mempty

dropWhileEnd' :: (a -> Bool) -> [a] -> [a]
dropWhileEnd' p = foldr help [] 
  where help x [] = if p x then [] else [x]
        help x xs = x : xs

integer :: [Int] -> Int
integer = foldr go 0 . zip [0..] . reverse
  where go (a, b) y = b * (10 ^ a) + y

fraction :: [Int] -> Float
fraction = foldr go 0 . zip [1..]
  where go (a, b) y = (fromIntegral b) * (1.0 / (10 ^ a)) + y

apply :: Int -> (a -> a) -> a -> a
apply x f = foldr (\x y -> f . y) id [1..x]

perms' :: Eq a => [a] -> [[a]]
perms' [] = [[]]
perms' xs = [x:ys | x <- xs, ys <- perms' (remove' x xs)]

remove' :: Eq a => a -> [a] -> [a]
remove' x = snd . foldr go (True, [])
  where go a (b, c)
          | b && x == a = (False, c)
          | otherwise = (b, a : c)

concat' :: [[a]] -> [a]
concat' xss = foldl op id xss []
    where op f xs = (++ xs) . f

steep :: (Ord a, Num a) => [a] -> Bool
steep xs =  all go $ zip (drop 1 xs) (drop 1 $ scanl (+) 0 xs)
    where go (a, b) = a > b

 
-- backwards from above steep
betterSteep :: (Ord a, Num a) => [a] -> (a, Bool)
betterSteep [] = (0, True)
betterSteep (x:xs) = (x + s, x > s && b)
  where (s, b) = betterSteep xs
