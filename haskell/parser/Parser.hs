module Parser where

import Text.Read
import Control.Applicative

newtype Parser a = Parser { runParse :: String -> (a, String)}

instance Functor Parser where
  
  fmap :: (a -> b) -> Parser a -> Parser b
  fmap f (Parser g) = Parser $ \s ->
    let (a, ns) = g s
    in (f a, ns)

instance Applicative Parser where
  
  pure :: a -> Parser a
  pure a = Parser $ \s -> (a, s)

  (<*>) :: Parser (a -> b) -> Parser a -> Parser b
  (<*>) (Parser f) (Parser g) = Parser $ \s ->
    let (a, ns) = g s
        (h, fs) = f ns
    in (h a, fs)

instance Monad Parser where
  
  return = pure

  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  (>>=) (Parser f) g = Parser $ \s ->
    let (a, ns) = f s
    in runParse (g a) ns

char :: Char -> Parser (Maybe Char)
char c = Parser $ \s -> f s
  where f "" = (Nothing, "")
        f (a : as) = 
          if a == c then (Just a, as) else (Nothing, "")

string :: String -> Parser (Maybe String)
string as = go as []
  where go "" acc = Parser $ \s -> (sequenceA acc, s) 
        go (a: as) acc = char a >>= \b -> go as (acc ++ [b])

float :: String -> Parser (Maybe Float)
float s = (=<<) (readMaybe :: String -> Maybe Float) <$> string s

fraction :: String -> Parser (Maybe Float)
fraction s =
  float l >>= \x ->
    char '/' >>
      float r >>= \y ->
        Parser $ \s -> (liftA2 (/) x y, s)
  where (l, r) = fmap (drop 1) $ break (=='/') s


parseabc =
  char 'a' >>= \a ->
    char 'b' >>=  \b ->
      char 'c' >>= \c ->
        Parser $ \s -> (sequenceA [a, b, c], s)



  
