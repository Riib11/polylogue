module AI.Agent.Chat.Memory where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.State (gets)
import Data.Either (Either)
import Data.Tuple (Tuple)
import Data.Variant (Variant)
import Prim.Row (class Nub, class Union)
import Record as R
import Type.Proxy (Proxy(..))

type Agent msg states errors queries = Agent.Agent states errors (Queries msg queries)

type States msg states =
  ( history :: Array msg 
  | states )

type Queries msg queries =
  ( get :: Agent.Inquiry Unit (Array msg)
  , append :: Agent.Inquiry msg Unit
  | queries )

_get = Proxy :: Proxy "get"
get :: forall msg states errors queries m.
  Agent.QueryM "get" (Agent.Inquiry Unit (Array msg)) (States msg states) errors (Queries msg queries) m (Array msg)
get = Agent.inquire _get unit

_append = Proxy :: Proxy "append"
append :: forall msg states errors queries m. 
  msg -> 
  Agent.QueryM "append" (Agent.Inquiry msg Unit) (States msg states) errors (Queries msg queries) m Unit
append msg = Agent.inquire _append msg

extend :: forall msg states errors queries m. 
  Monad m =>
  (msg -> Agent.AgentM (States msg states) errors m Unit) ->
  Agent.ExtensibleAgent (States msg states) errors queries (Queries msg queries) m
extend append_impl =
  (Agent.defineInquiry _get \_ -> gets _.history) >>>
  (Agent.defineInquiry _append append_impl)

run' :: forall msg states errors m a. 
  Nub (States msg states) (States msg states) =>
  Agent.ExtensibleRunner states (States msg states) errors m a
run' = Agent.run' {history: []}
