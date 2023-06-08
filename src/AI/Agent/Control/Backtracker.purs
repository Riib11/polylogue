module AI.Agent.Control.Backtracker where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.State (gets, modify_, put)
import Data.Generic.Rep (class Generic)
import Data.List (List)
import Data.List as List
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Prim.Row (class Lacks)
import Record as R
import Type.Proxy (Proxy(..))

_checkpoint = Proxy :: Proxy "checkpoint"
_checkpoints = Proxy :: Proxy "checkpoints"
_backtrack = Proxy :: Proxy "backtrack"

type States states = Agent.States
  ( checkpoints :: List (Record states) 
  | states )

type Errors errors = Agent.Errors 
  ( backtrack :: Error
  | errors )

data Error = BacktrackWhenNoCheckpoints

derive instance Generic Error _
instance Show Error where show x = genericShow x

type Queries queries = Agent.Queries
  ( checkpoint :: Agent.Inquiry Unit Unit
  , backtrack :: Agent.Inquiry Unit Unit
  | queries )

checkpoint :: forall states errors queries m. Monad m => Agent.QueryF (States states) (Errors errors) (Queries queries) m Unit
checkpoint = Agent.inquire _checkpoint unit

backtrack :: forall states errors queries m. Monad m => Agent.QueryF (States states) (Errors errors) (Queries queries) m Unit
backtrack = Agent.inquire _backtrack unit

extend :: forall states errors queries m. Monad m => Lacks "checkpoints" states => Agent.ExtensibleAgent (States states) (Errors errors) queries (Queries queries) m
extend = 
  (Agent.defineInquiry _checkpoint \_ -> do
    modify_ \states -> states 
      { checkpoints = R.delete _checkpoints states List.: states.checkpoints }) >>>
  (Agent.defineInquiry _backtrack \_ -> do
    checkpoints <- gets _.checkpoints
    case List.uncons checkpoints of
      Nothing -> Agent.throwError _backtrack BacktrackWhenNoCheckpoints
      Just {head: state, tail: checkpoints'} -> do
        put (R.insert _checkpoints checkpoints' state)
  )
