module Vowels where

import Data.List
import Data.Maybe
import Control.Monad 


data Tree =
    Node Tree Int Tree
  | Leaf deriving (Eq, Show)

one :: [Int] -> (Int, ([Int], [Int]))
one xs = (ma, (drop 1) <$> splitAt indexMax xs)
    where indexMax = fromJust $ elemIndex (maximum xs) xs
          ma = maximum xs

buildTree :: [Int] -> Tree
buildTree [] = []
buildTree xs = Node (buildTree b) a (buildTree c)
    where (a, (b, c)) = one xs

depths :: Tree -> [Int]
depths tree = go 0 tree
  where
    go _ Leaf = []
    go acc (Node Leaf _ Leaf) = [acc]
    go acc (Node left _ right) = (go (acc + 1) left) ++ [acc] ++ (go (acc + 1) right)

readLoop :: Int -> IO ()
readLoop 0 = return ()
readLoop x = do
  _ <- getLine
  xs <- getLine
  putStrLn $ intercalate " " $ map show $ depths $ buildTree $ map (read :: String -> Int) $ words xs
  readLoop (x - 1)

main :: IO ()
main = do
  testCases <- (read <$> getLine) :: (IO Int)
  readLoop testCases
