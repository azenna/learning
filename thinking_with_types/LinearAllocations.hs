{-# LANGUAGE DataKinds #-}

module LinearAllocations where

import Control.Monad.Indexed
import Data.Coerce
import Fcf
import GHC.TypeLits (Nat)
import qualified GHC.TypeLits as TL
import IndexedMonads
import Language.Haskell.DoNotation
import System.IO hiding (Handle, openFile)
import qualified System.IO as SIO
import Prelude hiding (Monad (..), pure)

data LinearState = LinearState
  { linearNextKey :: Nat
  , linearOpenKeys :: [Nat]
  }

newtype
  Linear
    s
    (i :: LinearState)
    (j :: LinearState)
    a = Linear
  {unsafeRunLinear :: Ix IO i j a}
  deriving (IxFunctor, IxPointed, IxApplicative, IxMonad)

newtype Handle s key = Handle
  {unsafeGetHandle :: SIO.Handle}

openFile ::
  FilePath ->
  IOMode ->
  Linear
    s
    ('LinearState next open)
    ('LinearState (next TL.+ 1) (next ': open))
    (Handle s next)
openFile = coerce SIO.openFile

type IsOpen (key :: k) (open :: [k]) = IsJust =<< Find (TyEq key) open

type Close (key :: k) (open :: [k]) = Filter (Not <=< TyEq key) open

closeFile ::
  (Eval (IsOpen key open) ~ 'True) =>
  Handle s key ->
  Linear
    s
    ('LinearState next open)
    ('LinearState next (Eval (Close key open)))
    ()
closeFile = coerce SIO.hClose

runLinear ::
  ( forall s.
    Linear
      s
      ('LinearState 0 '[])
      ('LinearState n '[])
      a
  ) ->
  IO a
runLinear s = coerce s
