module AI.Agent.Chat.Echo where

import Prelude

import AI.Agent.Chat as Chat
import AI.AgentInquiry (defineInquiry) as Agent
import Data.Array as Array
import Data.Maybe (Maybe(..))

-- | A chat agent that echos the user's prompt.

extend :: forall msg states errors queries m.
  Monad m =>
  { default :: msg } ->
  Chat.ExtensibleAgent msg states errors queries m
extend params =
  Agent.defineInquiry Chat._chat (Array.last >>> case _ of
    Nothing -> pure params.default
    Just last -> pure last)

