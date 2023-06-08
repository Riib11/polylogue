-- | A Memory agent that maintains the entire chat history.
module AI.Agent.Chat.Memory.Verbatim where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat.Memory as Memory
import Control.Monad.State (modify_)
import Data.Array as Array
import Record as R

type States msg states = Memory.States msg states
type Errors errors = Memory.Errors errors
type Queries msg queries = Memory.Queries msg queries

extend :: forall msg states errors queries m.
  Monad m =>
  Agent.ExtensibleAgent (States msg states) (Errors errors) queries (Queries msg queries) m
extend = Memory.extend
  { append: \msg -> modify_ (R.modify Memory._history (_ `Array.snoc` msg)) }
