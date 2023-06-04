module AI.Agent.Dialogue.Echo where

import Prelude

import AI.Agent.Dialogue as Dialogue
import Data.Array.NonEmpty as NonEmptyArray

-- | A dialogue agent that echos the user's prompt.
define :: forall m errors. Monad m => Dialogue.Agent errors m
define = Dialogue.define \history -> pure $ NonEmptyArray.last history
