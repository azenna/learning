{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

import Control.Applicative (Applicative (liftA2))
import Control.Monad.Writer
import Data.Aeson (Value (..), object, (.=))
import Data.Aeson.Key (fromString, fromText)
import Data.Kind (Type)
import Data.Text (Text, pack)
import Data.Typeable
import Data.Vector (fromList)
import GHC.Generics
import GHC.TypeLits
import qualified GHC.TypeLits as Err

data Person = Person
    { name :: String
    , age :: Int
    , phone :: Maybe String
    , permissions :: [Bool]
    }
    deriving (Generic)

mergeObjects :: Value -> Value -> Value
mergeObjects (Object a) (Object b) = Object $ a <> b

emitRequired ::
    forall nm.
    (KnownSymbol nm) =>
    Writer [Text] ()
emitRequired = tell . pure . pack . symbolVal $ Proxy @nm

type family ToJSONType (a :: Type) :: Symbol where
    ToJSONType Int = "integer"
    ToJSONType Integer = "integer"
    ToJSONType Float = "number"
    ToJSONType double = "number"
    ToJSONType String = "string"
    ToJSONType Bool = "boolean"
    ToJSONType [a] = "array"
    ToJSONType a = TypeName a

type family TypeName (t :: Type) :: Symbol where
    TypeName t = RepName (Rep t)

type family RepName (t :: Type -> Type) :: Symbol where
    RepName (D1 ('MetaData nm _ _ _) _) = nm

makeTypeObj :: forall a. (KnownSymbol (ToJSONType a)) => Value
makeTypeObj = object [fromString "type" .= String (pack . symbolVal $ Proxy @(ToJSONType a))]

makeProperyObj ::
    forall name.
    (KnownSymbol name) =>
    Value ->
    Value
makeProperyObj v =
    object
        [fromText (pack (symbolVal $ Proxy @name)) .= v]

class GSchema (a :: Type -> Type) where
    gschema :: Writer [Text] Value
