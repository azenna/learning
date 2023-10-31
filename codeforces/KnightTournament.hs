module KnightTournament where

parseFight s = (go . map (read :: String -> Int) . words)
    go [a, b, c] = (a, b, c)

main :: IO ()
main = do
   _ <- getLine
   fight <- parseFight <$> getLine



  1
0 1 2 3

