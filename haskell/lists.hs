subs :: [Char] -> [[Char]]

subs [] = []
subs s = takeWhile (/= ' ') s : subs (drop 1 (dropWhile (/= ' ') s))
