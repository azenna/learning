data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood _ = Blah

greetIfCool :: String -> String
greetIfCool g =
    if cool
        then "eyy what's shaking"
        else "pshh"
    where cool = g == "downright frosty yo"

tupFunc :: Num b => (b, [a]) -> (b, [a]) -> (b, [a])
tupFunc (a, b) (c, d) = (a + c, b ++ d)

awesome = ["papuchon", "curry", ":)"]
also = ["Quake", "The Simons"]
allAwesome = [awesome, also]
isPalindrome :: Eq a => [a] -> Bool
isPalindrome x = x == reverse x

abs' x = if x < 0 then x * (-1) else x

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f x y = ((snd x, snd y), (fst x, fst y))

lengthPlusOne xs = w + 1
    where w = length xs

id' x = x

fst' :: (a, b) -> a
fst' (a, b) = a