module Data.Default where

import Prelude

class HasDefault a where _default :: a

newtype Default a = Default a

default :: forall a. HasDefault (Default a) => a
default = case _default of Default a -> a
