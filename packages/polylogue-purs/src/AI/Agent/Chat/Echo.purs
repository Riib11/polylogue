-- | A chat agent that echos the user's prompt.
module AI.Agent.Chat.Echo where

import Prelude

import AI.Agent.Chat as Chat
import AI.AgentInquiry as Agent
import AI.Agent as Agent
import Data.Array as Array
import Data.Maybe (Maybe(..))

type States states = Chat.States states
type Errors errors = Chat.Errors errors
type Queries msg queries = Chat.Queries msg queries

extend :: forall msg states errors queries m.
  Monad m =>
  { default :: msg } ->
  Agent.ExtensibleAgent (States states) (Errors errors) queries (Queries msg queries) m
extend params =
  Agent.defineInquiry Chat._chat (Array.last >>> case _ of
    Nothing -> pure params.default
    Just last -> pure last)

