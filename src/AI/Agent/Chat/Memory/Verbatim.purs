module AI.Agent.Chat.Memory.Verbatim where

import Prelude

import AI.Agent.Chat.Memory as Memory
import Control.Monad.State (modify_)
import Data.Array as Array
import Record as R

-- | A Memory agent that maintains the entire chat history.

extend :: forall msg states errors queries m.
  Monad m =>
  Memory.ExtensibleAgent msg states errors queries m
extend = Memory.extend
  { append: \msg -> modify_ (R.modify Memory._history (_ `Array.snoc` msg)) }
