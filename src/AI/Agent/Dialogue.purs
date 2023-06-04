module AI.Agent.Dialogue where

import Prelude

import AI.Agent (Agent)
import AI.LLM.Chat as Chat
import Data.Maybe (Maybe)
import Type.Proxy (Proxy(..))

-- | A dialogue agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

type DialogueAgent inputs errors m = Agent
  "dialogue"
  {systemPrompt :: Maybe String}
  {history :: Array Chat.ChatMessage}
  errors
  DialogueQuery
  m

_dialogue = Proxy :: Proxy "dialogue"

_prompt = Proxy :: Proxy "prompt"

data DialogueQuery a
  = Prompt Chat.ChatMessage (Chat.ChatMessage -> a)
  | GetHistory (Array Chat.ChatMessage -> a)
derive instance Functor DialogueQuery

