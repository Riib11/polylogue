module AI.Agent.ChatWithMemory where

import Prelude


import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Memory as Memory
import AI.Agent.Manager as Manager
import AI.AgentInquiry as Agent
import Data.Traversable (for_)
import Prim.Row (class Union)
import Type.Proxy (Proxy(..))

type Class memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m =
  Agent.Class (States memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states m) errors queries m

type Inst memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m =
  Agent.Inst (States memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states m) errors queries m

type ExtensibleClass memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m = 
  Agent.ExtensibleClass (States memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states m) errors queries (Queries queries) m

type 
  States
    memoryStates memoryErrors memoryQueries 
    chatStates chatErrors chatQueries 
    states m = 
  Manager.States 
    ( chat :: Chat.Inst chatStates chatErrors chatQueries m
    , memory :: Memory.Inst memoryStates memoryErrors memoryQueries m )
    states

_chat = Proxy :: Proxy "chat"
_memory = Proxy :: Proxy "memory"

type Queries queries = Chat.Queries queries

define :: forall 
  chatStates chatErrors chatErrors_ chatQueries
  memoryStates memoryErrors_ memoryErrors memoryQueries
  states errors queries m.
  Union memoryErrors memoryErrors_ errors =>
  Union chatErrors chatErrors_ errors =>
  Monad m =>
  ExtensibleClass memoryStates memoryErrors memoryQueries chatStates chatErrors chatQueries states errors queries m
define =
  Agent.addInquiry Chat._chat \msgs -> do
    for_ msgs (Manager.subInquire _memory Memory._append)
    history <- Manager.subInquire _memory Memory._get unit
    response <- Manager.subInquire _chat Chat._chat history
    Manager.subInquire _memory Memory._append response
    pure response
