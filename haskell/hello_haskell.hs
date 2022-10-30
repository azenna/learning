sayHello :: String -> IO()
sayHello x =
  putStrLn("hello, " ++ x ++ "!")

square x = x * x
circleArea r = pi * square r

mult1 = x * y
  where x = 5
        y = 6

a = x * 3 + y
  where x = 3
        y = 1000

b = x * 5
  where y = 10
        x = 10 * 5 + y

c = z / x + y
  where x = 7
        y = negate x
        z = y * 10

waxOn = x * 5
  where z = 7
        y = z + 8
        x = y ^ 2

triple = (*3)

waxOff = triple

myGreeting :: String
myGreeting = "hello" ++ "world"

hello :: String
hello = "hello"

world :: String
world = "world!"

exa x = x ++ "!"
exb = "y"
exc = drop 8

thirdChar :: String -> Char
thirdChar x = x !! 2

iChar :: Int -> Char
iChar = (!!) "Curry is awesome!"

rvrs x = concat [drop 9 x, take 4 $ drop 5 x, take 5x]

main :: IO()
main = do
  putStrLn "Count to four for me:"
  putStr "one, two"
  putStr ", three, and"
  putStrLn " four!"

  putStrLn myGreeting
  putStrLn secondGreeting
  where secondGreeting = concat [hello, " ", world]
