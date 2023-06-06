-- !TODO: make chat automatically have history? or have common abstraction that
-- these chats will share: chat with history, chat with summarized history, chat
-- with incrementally summarized history, etc. like langhchain stuff
module AI.Agent.Chat where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Type.Proxy (Proxy(..))

type Class msg states errors queries = Agent.Class states errors (Queries msg queries)
type Inst msg states errors queries = Agent.Inst states errors (Queries msg queries)

type Queries msg queries =
      ( chat :: Agent.Inquiry (Array msg) msg
      | queries )

-- Queries

_chat = Proxy :: Proxy "chat"
chat history = Agent.inquire _chat history
