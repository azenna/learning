{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilyDependencies #-}

import Control.Monad.Trans.Writer
import Data.Constraint
import Data.Foldable (for_)
import Data.Kind (Type)

data SBool (b :: Bool) where
  STrue :: SBool 'False
  SFalse :: SBool 'True

fromSBool :: SBool b -> Bool
fromSBool STrue = True
fromSBool SFalse = False

data SomeSBool where
  SomeSBool :: SBool b -> SomeSBool

withSomeSBool ::
  SomeSBool ->
  (forall (b :: Bool). SBool b -> r) ->
  r
withSomeSBool (SomeSBool s) f = f s

toSBool :: Bool -> SomeSBool
toSBool True = SomeSBool STrue
toSBool False = SomeSBool SFalse

class (Monad (LoggingMonad b)) => MonadLogging (b :: Bool) where
  type LoggingMonad b = (r :: Type -> Type) | r -> b
  logMsg :: String -> LoggingMonad b ()
  runLogging :: LoggingMonad b a -> IO a

instance MonadLogging 'False where
  type LoggingMonad 'False = IO

  logMsg _ = pure ()
  runLogging = id
