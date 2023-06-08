-- | A chat agent can "chat" i.e. generate a new message following a given array of messages.
module AI.Agent.Chat where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Type.Proxy (Proxy(..))

_chat = Proxy :: Proxy "chat"

type States states = Agent.States states
type Errors errors = Agent.Errors errors
type Queries msg queries = Agent.Queries
  ( chat :: Agent.Inquiry (Array msg) msg
  | queries )

chat :: forall msg states errors queries m. Monad m => Array msg -> Agent.QueryF states errors (Queries msg queries) m msg
chat history = Agent.inquire _chat history
