module AI.Agent.Summarizer where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Type.Proxy (Proxy(..))

_summarize = Proxy :: Proxy "summarize"

type States states = Agent.States states
type Errors errors = Agent.Errors errors
type Queries msg queries = Agent.Queries
  ( summarize :: Agent.Inquiry msg msg
  | queries )

summarize :: forall msg states errors queries m. Monad m => msg -> Agent.QueryF (States states) (Errors errors) (Queries msg queries) m msg
summarize msg = Agent.inquire _summarize msg