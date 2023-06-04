module AI.Agent.Chat.Echo where

import Prelude

import AI.Agent.Chat as Chat
import Data.Array.NonEmpty as NonEmptyArray
import Data.Functor.Variant as VF

-- | A dialogue agent that echos the user's prompt.
define :: forall states errors m. Monad m => Chat.Agent states errors () m
define = Chat.define VF.case_ \history -> 
  pure $ NonEmptyArray.last history
