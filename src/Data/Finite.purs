module Data.Finite where

import Data.Tuple.Nested
import Prelude

import Control.Assert (assert, assertI)
import Control.Assert.Assertions (just, memberOfArray)
import Data.Array as Array
import Data.Enum (Cardinality(..))
import Data.Maybe (Maybe)

finiteSucc :: forall a. Show a => Eq a => Array a -> a -> Maybe a
finiteSucc domain a = assert memberOfArray (a /\ domain) \i -> Array.index domain (i + 1)

finitePred :: forall a. Show a => Eq a => Array a -> a -> Maybe a
finitePred domain a = assert memberOfArray (a /\ domain) \i -> Array.index domain (i - 1)

finiteBottom :: forall a. Array a -> a
finiteBottom domain = assertI just $ Array.head domain

finiteTop :: forall a. Array a -> a
finiteTop domain = assertI just $ Array.last domain

finiteCardinality :: forall a. Array a -> Cardinality a
finiteCardinality domain = Cardinality $ Array.length domain

finiteToEnum :: forall a. Array a -> Int -> Maybe a
finiteToEnum domain = Array.index domain

finiteFromEnum :: forall a. Eq a => Array a -> a -> Int
finiteFromEnum domain a = assertI just $ Array.elemIndex a domain
