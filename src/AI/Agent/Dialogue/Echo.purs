module AI.Agent.Dialogue.Echo where

import Prelude

import AI.Agent.Dialogue as Dialogue
import Data.Array.NonEmpty as NonEmptyArray

-- | A dialogue agent that echos the user's prompt.
define :: forall m states errors. Monad m => Dialogue.Agent states errors m
define = Dialogue.define \history -> pure $ NonEmptyArray.last history
