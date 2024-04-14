main = do
  x <- getLine
  putStrLn $ f '\n' x

f cPrev [] = ""
f cPrev (c:cs)
  | c == cPrev = f c cs
  | otherwise = c : (f c cs)
