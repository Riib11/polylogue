-- | A chat memory agent maintains a history of messages.
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

type States msg states =
  ( history :: Array msg 
  | states )

type Errors errors = Agent.Errors errors

type Queries msg queries =
  ( get :: Agent.Inquiry Unit (Array msg)
  , append :: Agent.Inquiry msg Unit
  | queries )

get :: forall msg states errors queries m. Monad m => Agent.QueryF (States msg states) (Errors errors) (Queries msg queries) m (Array msg)
get = Agent.inquire _get unit

append :: forall msg states errors queries m. msg -> Monad m => Agent.QueryF (States msg states) (Errors errors) (Queries msg queries) m Unit
append msg = Agent.inquire _append msg

extend :: forall msg states errors queries m. Monad m => { append :: msg -> Agent.AgentM (States msg states) (Errors errors) m Unit } -> Agent.ExtensibleAgent (States msg states) errors queries (Queries msg queries) m
extend params =
  (Agent.defineInquiry _get \_ -> gets _.history) >>>
  (Agent.defineInquiry _append params.append)

extendInit :: forall msg states m. Applicative m => Nub (States msg states) (States msg states) => Agent.ExtensibleInitialization states (States msg states) m
extendInit = Agent.extendInit {history: []}

