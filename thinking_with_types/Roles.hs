{-# LANGUAGE RoleAnnotations #-}

module Roles where

import   Data.Coerce (Coercible(..),   coerce)
import   Data.Monoid (Sum (..))

fastSum :: [Int] -> Int
fastSum = getSum . mconcat . coerce

data BST v =
    Empty
  | Branch (BST v) v (BST v)

type role BST nominal
