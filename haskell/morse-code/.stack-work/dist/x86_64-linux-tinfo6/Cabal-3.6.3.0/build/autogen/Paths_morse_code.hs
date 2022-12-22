{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_morse_code (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/bin"
libdir     = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/lib/x86_64-linux-ghc-9.2.5/morse-code-0.1.0.0-9vKiOhptYmc249DSNPIbd1"
dynlibdir  = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/lib/x86_64-linux-ghc-9.2.5"
datadir    = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/share/x86_64-linux-ghc-9.2.5/morse-code-0.1.0.0"
libexecdir = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/libexec/x86_64-linux-ghc-9.2.5/morse-code-0.1.0.0"
sysconfdir = "/home/xenna/Programming/learning/haskell/morse-code/.stack-work/install/x86_64-linux-tinfo6/d497fa0c978ff9a44e1eb31733ad45bdf3dcecfb0d9509a9a15c02e6599ced81/9.2.5/etc"

getBinDir     = catchIO (getEnv "morse_code_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "morse_code_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "morse_code_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "morse_code_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "morse_code_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "morse_code_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
