import Text.Trifecta
import Text.Trifecta.Combinators
import Text.Parsec.Prim ((<|>))

stop :: Parser a
stop = unexpected "stop"

one = char '1'

one' = one >> stop

oneTwo = char '1' >> char '2'

oneTwo' = oneTwo >> stop

oneTwoString = string "12"

type SORI = Either String Int

sori = (Left <$> some letter) <|> (Right <$> integer)


testParse :: Parser Char -> IO ()
testParse p =
  print $ parseString p mempty "123"

pNL s =
  putStrLn ('\n' : s)

main = do
  pNL "stop:"
  testParse stop

  pNL "one:"
  testParse one

  pNL "one':"
  testParse one'

  pNL "oneTwo:"
  testParse oneTwo

  pNL "oneTwo':"
  testParse oneTwo'

  pNL "eof fail: "
  print $ parseString eof mempty "123"

  pNL "string onetwo"
  print $ parseString oneTwoString mempty "123"
