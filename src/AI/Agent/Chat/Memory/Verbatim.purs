module AI.Agent.Chat.Memory.Verbatim where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat.Memory as Memory
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.State (gets, modify_)
import Data.Array as Array
import Record as R
import Type.Proxy (Proxy(..))

-- | Maintains the entire chat history.
define =
  (Agent.addInquiry Memory._get \_ -> gets _.history) >>>
  (Agent.addInquiry Memory._append \msg -> modify_ (R.modify _history (_ `Array.snoc` msg)))

_history = Proxy :: Proxy "history"
