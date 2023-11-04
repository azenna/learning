parse :: String -> [Int]
parse = map read . words

parseTup :: [Int] -> (Int, Int, Int)
parseTup [x, y, z] = (x, y, z)

fizzBuzz :: (Int, Int) -> Int -> String
fizzBuzz (x, y) z
  | rem z x == 0 && rem z y == 0 = "FizzBuzz"
  | rem z x == 0 = "Fizz"
  | rem z y == 0 = "Buzz"
  | otherwise = show z

main :: IO ()
main = do
  (x, y, n) <- (parseTup . parse) <$> getLine
  traverse (putStrLn . fizzBuzz (x, y)) [1..n]
  pure ()
