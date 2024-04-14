
main :: IO ()
main = do
  nums <- map (read :: String -> Int) <$> words <$> getLine
  print $ scanl (+) 0 nums
  
