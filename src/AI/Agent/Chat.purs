-- !TODO: make chat automatically have history? or have common abstraction that
-- these chats will share: chat with history, chat with summarized history, chat
-- with incrementally summarized history, etc. like langhchain stuff
module AI.Agent.Chat where


import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Type.Proxy (Proxy(..))

_chat = Proxy :: Proxy "chat"

type Agent msg states errors queries m = 
  Agent.Agent states errors (Queries msg queries) m

type ExtensibleAgent msg states errors queries m = 
  Agent.ExtensibleAgent states errors queries (Queries msg queries) m

type Queries msg queries =
  ( chat :: Agent.Inquiry (Array msg) msg
  | queries )

chat :: forall msg states errors queries m. Monad m => Array msg -> Agent.QueryF states errors (Queries msg queries) m msg
chat history = Agent.inquire _chat history
