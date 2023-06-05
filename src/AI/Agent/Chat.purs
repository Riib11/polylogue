module AI.Agent.Chat where

import Prelude

import AI.Agent as Agent
import API.Chat.OpenAI as Chat
import Control.Monad.State (gets, modify, modify_)
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Record as R
import Type.Proxy (Proxy(..))

_chat = Proxy :: Proxy "chat"

-- | A chat agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

define config =
  (Agent.addQuery _prompt \(Prompt promptMsg k) -> do
    history <- gets _.history
    -- append prompt message to history
    st <- modify \st -> st {history = st.history `Array.snoc` promptMsg}
    -- reply
    reply <- config.reply $ NonEmptyArray.snoc' history promptMsg
    -- append reply to history
    modify_ \st' -> st' {history = st.history `Array.snoc` reply}
    -- yield reply
    pure $ k reply) >>>
  (Agent.addQuery _getHistory \(GetHistory k) -> 
    k <$> gets _.history)

new cls input states = Agent.new cls $ 
  R.union
    { history: case input.system of
        Nothing -> input.history
        Just str -> [Chat.systemMessage str] <> input.history }
    states

_prompt = Proxy :: Proxy "prompt"
prompt promptMsg = FV.inj _prompt <<< Prompt promptMsg
data Prompt a = Prompt Chat.Message (Chat.Message -> a)
derive instance Functor Prompt

_getHistory = Proxy :: Proxy "getHistory"
getHistory = FV.inj _getHistory <<< GetHistory
data GetHistory a = GetHistory (Array Chat.Message -> a)
derive instance Functor GetHistory