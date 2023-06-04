module AI.Agent.Dialogue.Echo where

import Prelude

import AI.Agent.Dialogue as Dialogue
import Data.Array.NonEmpty as NonEmptyArray
import Data.Functor.Variant as VF

-- | A dialogue agent that echos the user's prompt.
define :: forall states errors m. Monad m => Dialogue.Agent states errors () m
define = Dialogue.define VF.case_ \history -> 
  pure $ NonEmptyArray.last history
