module AI.Agent.Chat.Memory where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.State (gets)
import Prim.Row (class Nub)
import Type.Proxy (Proxy(..))

_append = Proxy :: Proxy "append"
_get = Proxy :: Proxy "get"
_history = Proxy :: Proxy "history"

type ExtensibleAgent msg states errors queries m = Agent.ExtensibleAgent (States msg states) errors queries (Queries msg queries) m
type Agent msg states errors queries m = Agent.Agent (States msg states) errors (Queries msg queries) m

type States msg states =
  ( history :: Array msg 
  | states )

type Queries msg queries =
  ( get :: Agent.Inquiry Unit (Array msg)
  , append :: Agent.Inquiry msg Unit
  | queries )

get :: forall msg states errors queries m. Monad m => Agent.QueryF (States msg states) errors (Queries msg queries) m (Array msg)
get = Agent.inquire _get unit

append :: forall msg states errors queries m. msg -> Monad m => Agent.QueryF (States msg states) errors (Queries msg queries) m Unit
append msg = Agent.inquire _append msg

extend :: forall msg states errors queries m. Monad m => { append :: msg -> Agent.AgentM (States msg states) errors m Unit } -> ExtensibleAgent msg states errors queries m
extend params =
  (Agent.defineInquiry _get \_ -> gets _.history) >>>
  (Agent.defineInquiry _append params.append)

run' :: forall msg states errors m a. Nub (States msg states) (States msg states) => Agent.ExtensibleRunner states (States msg states) errors m a
run' = Agent.run' {history: []}
