import qualified Data.Map as M
import Data.Maybe
import Data.List
import System.IO
import System.Exit

parseDict :: [String] -> M.Map String String
parseDict = foldr f M.empty 

f s m = M.insert b a m  
  where [a, b] = words s


translate :: M.Map String String -> String -> String
translate m s = fromMaybe "eh" $ M.lookup s m 

readDict = do
  x <- getLine
  case words x of
    [] -> do
      putStrLn "got here"
      pure M.empty
    [a, b] -> do
      m <- readDict
      pure $ M.insert b a m

readMsg = do
  x <- isEOF
  case x of
    True -> pure ""
    False -> do
      c <- getChar
      d <- readMsg
      pure (c : d)

main = do
  -- dict <- readDict
  -- readMsg dict
  readMsg
