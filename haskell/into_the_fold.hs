import Data.Time

data DatabaseItem = DbString String | DbNumber Integer | DbDate UTCTime deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase = [DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123)), DbNumber 9001, DbString "Hello, world!", DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))]

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate [] = []
filterDbDate (DbDate x : xs) = x : filterDbDate xs
filterDbDate (_ : xs) = filterDbDate xs

-- better version?
filterDbDate2 :: [DatabaseItem] -> [UTCTime]
filterDbDate2 = foldr f []
  where
    f (DbDate x) = (x :)
    f _ = id

stop = "pbtdkg"

vowel = "aeiou"

stop_vowel_stop = [(x, y, z) | x <- stop, y <- vowel, z <- stop]

myAny f = foldr ((||) . f) False

myElem x = foldr ((||) . (== x)) False

myRev :: [a] -> [a]
myRev = foldl (flip (:)) []

myMap f = foldr ((:) . f) []
