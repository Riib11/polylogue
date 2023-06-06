module AI.Agent.Chat.Memory where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Type.Proxy (Proxy(..))

type Class states errors queries = Agent.Class states errors (Queries queries)
type Inst states errors queries = Agent.Inst states errors (Queries queries)

type Queries queries =
  ( get :: Agent.Inquiry Unit (Array ChatOpenAI.Message)
  , append :: Agent.Inquiry ChatOpenAI.Message Unit
  | queries )

_get = Proxy :: Proxy "get"
get = Agent.inquire _get unit

_append = Proxy :: Proxy "append"
append msg = Agent.inquire _append msg
