import Data.List
go :: Int -> IO ()
go 0 = pure ()
go n = do
  s <- getLine
  if (length (filter (=='N') s) == 1)
    then putStrLn "NO"
    else putStrLn "YES"
  go (n - 1)
 

main :: IO ()
main = do
  x <- (read :: String -> Int) <$> getLine
  go x

