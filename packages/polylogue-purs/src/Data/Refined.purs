module Data.Refined where

import Data.Either.Nested
import Prelude

import Control.Bug (bug)
import Data.Either (Either(..))

class Refined a b where
  refinement :: a -> String \/ b

makeRefined :: forall a b. Refined a b => a -> b
makeRefined a = case refinement a of
  Left err -> bug $ "Failed makeRefined: " <> show err
  Right b -> b
