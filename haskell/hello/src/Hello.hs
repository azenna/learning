module Hello where

sayHello :: String -> IO ()
sayHello = putStrLn . (++) "Hi " 
