import Data.Char

sumDigits :: String -> Int
sumDigits = sum . map digitToInt

parse = read :: (String -> Int)

isHarshad :: String -> Bool
isHarshad s = parse s `rem` sumDigits s == 0

incString :: String -> String
incString = show . (+1) . parse

findHarshad :: String -> String
findHarshad s = if isHarshad s then s else findHarshad (incString s)

main :: IO ()
main = do
  x <- getLine
  putStrLn $ findHarshad x
  
