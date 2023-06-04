module AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import AI.LLM.Chat as Chat
import Type.Proxy (Proxy(..))

-- | A dialogue agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

_dialogue = Proxy :: Proxy "dialogue"

type DialogueAgent errors m = Agent.Agent
  {history :: Array Chat.ChatMessage}
  errors
  DialogueQuery
  m

data DialogueQuery a
  = Prompt Chat.ChatMessage (Chat.ChatMessage -> a)
  | GetHistory (Array Chat.ChatMessage -> a)
derive instance Functor DialogueQuery

makeDialogueAgent :: forall errors m. Monad m => DialogueAgent errors m
makeDialogueAgent = Agent.makeAgent ?a
