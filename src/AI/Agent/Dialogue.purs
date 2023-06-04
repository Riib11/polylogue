module AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import AI.LLM.Chat as Chat
import Control.Monad.State (gets, modify, modify_)
import Data.Array as Array
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NonEmptyArray
import Data.Maybe (Maybe(..))
import Type.Proxy (Proxy(..))

-- | A dialogue agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

_dialogue = Proxy :: Proxy "dialogue"

type Agent errors m = Agent.Agent State errors Query m

type Input = 
  { system :: Maybe String
  , history :: Array Chat.ChatMessage
  }

type State = 
  { history :: Array Chat.ChatMessage }

data Query a
  = Prompt Chat.ChatMessage (Chat.ChatMessage -> a)
  | GetHistory (Array Chat.ChatMessage -> a)
derive instance Functor Query

new :: forall errors m. Monad m => Agent errors m -> Input -> Agent.Id State errors Query m
new agent input = Agent.new agent
  { history: case input.system of
      Nothing -> input.history
      Just str -> [Chat.systemMessage str] <> input.history
  }

define :: forall errors m. Monad m => (NonEmptyArray Chat.ChatMessage -> Agent.M State errors m Chat.ChatMessage) -> Agent errors m
define genReply = Agent.define case _ of
  Prompt promptMsg k -> do
    history <- gets _.history
    -- append prompt message to history
    st <- modify \st -> st {history = st.history `Array.snoc` promptMsg}
    -- reply
    reply <- genReply $ NonEmptyArray.snoc' history promptMsg
    -- append reply to history
    modify_ \st' -> st' {history = st.history `Array.snoc` reply}
    -- yield reply
    pure $ k reply
  GetHistory k -> k <$> gets _.history
