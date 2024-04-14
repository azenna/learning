{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Marsahlling where

import Data.Aeson
import Data.ByteString.Lazy (ByteString)
import Text.RawString.QQ (r)
import Control.Applicative ((<|>))

sectionJson :: ByteString
sectionJson = [r|
{"section": {"host": "wikipedia.org"},
 "whatisit": {"red": "intoothandclaw"}
}
|]

data TestData = 
  TestData {
    section :: Host,
    what :: Color
  } deriving (Eq, Show)

instance FromJSON TestData where
  parseJSON (Object v) =
    TestData <$> v .: "section"
             <*> v .: "whatisit"
  parseJSON _ = fail "Expected object for test data"

instance FromJSON Host where
  parseJSON (Object v) =
    Host <$> v .: "host"

  parseJSON _ = fail "Expected object for Host"

instance FromJSON Color where
  parseJSON (Object v) = 
        (Red <$> v .: "red")
    <|> (Blue <$> v .: "blue")
    <|> (Yellow <$> v .: "yellow")
  parseJSON _ = fail "Expected an object for color"

newtype Host = Host String deriving (Eq, Show)

type Annotation = String

data Color =
    Red Annotation
  | Blue Annotation
  | Yellow Annotation
  deriving (Eq, Show)

main = do
  let d :: Maybe TestData
      d = decode sectionJson

  print d


