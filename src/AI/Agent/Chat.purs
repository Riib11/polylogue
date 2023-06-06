-- !TODO: make chat automatically have history? or have common abstraction that
-- these chats will share: chat with history, chat with summarized history, chat
-- with incrementally summarized history, etc. like langhchain stuff
module AI.Agent.Chat where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Type.Proxy (Proxy(..))

type Class states errors queries = Agent.Class states errors (Queries queries)
type Inst states errors queries = Agent.Inst states errors (Queries queries)

type Queries queries =
      ( chat :: Agent.Inquiry (Array ChatOpenAI.Message) ChatOpenAI.Message
      | queries )

-- Queries

_chat = Proxy :: Proxy "chat"
chat history = Agent.inquire _chat history
