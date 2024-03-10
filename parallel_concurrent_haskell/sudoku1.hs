import Control.DeepSeq
import Control.Exception
import Control.Parallel.Strategies
import Data.Maybe
import Example.Sudoku
import System.Environment

main :: IO ()
main = do
  [f] <- getArgs -- <1>
  file <- readFile f -- <2>
  let puzzles = lines file -- <3>
      solutions = runEval $ traverse (rpar . solve) puzzles
  -- (as, bs) = splitAt (length puzzles `div` 2) puzzles
  -- solutions = runEval $ do
  --   as' <- rpar (force (map solve as))
  --   bs' <- rpar (force (map solve bs))
  --   rseq as'
  --   rseq bs'
  --   return (as' ++ bs')
  print (length (filter isJust solutions)) -- <5>
  -- >>
