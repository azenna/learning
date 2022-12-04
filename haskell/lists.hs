subs :: [Char] -> [[Char]]

subs [] = []
subs s = takeWhile (/= ' ') s : subs (drop 1 (dropWhile (/= ' ') s))

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _ [] = []
myZipWith _ [] _ = []
myZipWith acc (x : xs) (y : ys) = (acc x y) : (myZipWith acc xs ys)

myZip :: [a] -> [b] -> [(a, b)]
myZip = myZipWith (,)

firstCap :: String -> Char
firstCap (x : _) = toUpper x
