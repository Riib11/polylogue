module AI.Agent.Chat.Memory where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Type.Proxy (Proxy(..))

type Class msg states errors queries = Agent.Class states errors (Queries msg queries)
type Inst msg states errors queries = Agent.Inst states errors (Queries msg queries)

type Queries msg queries =
  ( get :: Agent.Inquiry Unit (Array msg)
  , append :: Agent.Inquiry msg Unit
  | queries )

_get = Proxy :: Proxy "get"
get = Agent.inquire _get unit

_append = Proxy :: Proxy "append"
append msg = Agent.inquire _append msg

new cls = Agent.extensibleNew cls {history: []}