module AI.Agent.Chat.WithMemory where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Memory as Memory
import AI.Agent.Manager as Manager
import AI.AgentInquiry as Agent
import Data.Traversable (for_)
import Debug as Debug
import Prim.Row (class Union)
import Type.Proxy (Proxy(..))

type Class msg memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m =
  Agent.Class (States msg memoryStates memoryErrors memoryQueries chatStates chatErrors queries states m) errors (Queries msg queries) m

type Inst msg memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m =
  Agent.Inst (States msg memoryStates memoryErrors memoryQueries chatStates chatErrors queries states m) errors (Queries msg queries) m

type ExtensibleClass msg memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m = 
  Agent.ExtensibleClass (States msg memoryStates memoryErrors memoryQueries chatStates chatErrors queries states m) errors queries (Queries msg queries) m

type 
  States
    msg
    memoryStates memoryErrors memoryQueries 
    chatStates chatErrors chatQueries
    states m = 
  Manager.States 
    ( chat :: Chat.Inst msg chatStates chatErrors chatQueries m
    , memory :: Memory.Inst msg memoryStates memoryErrors memoryQueries m )
    states

_chat = Proxy :: Proxy "chat"
_memory = Proxy :: Proxy "memory"

type Queries msg queries = Chat.Queries msg
  ( getHistory :: Agent.Inquiry Unit (Array msg)
  | queries )

_getHistory = Proxy :: Proxy "getHistory"
getHistory = Agent.inquire _getHistory unit

define :: forall 
  msg
  chatStates chatErrors chatErrors_ chatQueries
  memoryStates memoryErrors_ memoryErrors memoryQueries
  states errors queries m.
  Union memoryErrors memoryErrors_ errors =>
  Union chatErrors chatErrors_ errors =>
  Monad m =>
  ExtensibleClass msg memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m
define =
  (Agent.addInquiry Chat._chat \msgs -> do
    for_ msgs (Manager.subInquire _memory Memory._append)
    history <- Manager.subInquire _memory Memory._get unit
    response <- Manager.subInquire _chat Chat._chat history
    Manager.subInquire _memory Memory._append response
    pure response) >>>
  (Agent.addInquiry _getHistory \_ -> do
    Manager.subInquire _memory Memory._get unit)

