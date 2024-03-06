{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -O -fplugin Test.Inspection.Plugin #-}

module InspectionTest where

import JsonSchema
import Test.Inspection

import Data.Aeson

mySchema :: Value
mySchema = schema @Person

inspect $ hasNoGenerics 'mySchema
