import Data.Char
import Control.Applicative

valid = [1, 1, 2, 2, 2, 8]

main :: IO ()
main = do
  xs <- (map (read :: (String -> Int)) . words) <$> getLine
  putStrLn $ unwords $ show <$> zipWith (-) valid xs
