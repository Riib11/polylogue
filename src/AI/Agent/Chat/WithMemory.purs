module AI.Agent.Chat.WithMemory where

import Prelude
import AI.Agent (ExtensibleAgent, QueryF) as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Memory as Memory
import AI.Agent.Manager as Manager
import AI.AgentInquiry (Inquiry, defineInquiry, inquire) as Agent
import Data.Traversable (for_)
import Type.Proxy (Proxy(..))

_getHistory = Proxy :: Proxy "getHistory"

type ExtensibleAgent msg memoryStates memoryQueries chatStates chatQueries states errors queries m = 
  Agent.ExtensibleAgent (States msg memoryStates memoryQueries chatStates chatQueries errors states m) errors queries (Queries msg queries) m

type
  States
    msg
    memoryStates memoryQueries 
    chatStates chatQueries
    errors states m = 
  Manager.States 
    ( chat :: Chat.Agent msg chatStates errors chatQueries m
    , memory :: Memory.Agent msg memoryStates errors memoryQueries m )
    ( chat :: Record chatStates
    , memory :: Record (Memory.States msg memoryStates) )
    states

_chat = Proxy :: Proxy "chat"
_memory = Proxy :: Proxy "memory"

type Queries msg queries = Chat.Queries msg
  ( getHistory :: Agent.Inquiry Unit (Array msg)
  | queries )

getHistory :: forall msg states errors queries m. Monad m => Agent.QueryF states errors (Queries msg queries) m (Array msg)
getHistory = Agent.inquire _getHistory unit

extend :: forall 
  msg
  chatStates chatQueries
  memoryStates memoryQueries
  states errors queries m.
  Monad m =>
  ExtensibleAgent msg memoryStates memoryQueries chatStates chatQueries states errors queries m
extend =
  (Agent.defineInquiry Chat._chat \msgs -> do
    for_ msgs \msg -> Manager.subDo _memory $ Memory.append msg
    history <- Manager.subDo _memory Memory.get
    response <- Manager.subDo _chat $ Chat.chat history
    Manager.subDo _memory $ Memory.append response
    pure response) >>>
  (Agent.defineInquiry _getHistory \_ -> do
    Manager.subDo _memory Memory.get)

