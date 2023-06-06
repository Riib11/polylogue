module AI.Agent.Chat where

-- import Prelude

-- import AI.Agent as Agent
-- import API.Chat.OpenAI as Chat
-- import Control.Monad.State (gets, modify, modify_)
-- import Data.Array as Array
-- import Data.Array.NonEmpty as NonEmptyArray
-- import Data.Functor.Variant as FV
-- import Data.Maybe (Maybe(..))
-- import Record as R
-- import Type.Proxy (Proxy(..))

-- _chat = Proxy :: Proxy "chat"

-- -- | A chat agent is an agent that can have a conversation with a single
-- -- | user. It maintains the history of chat messages.

-- define config =
--   (Agent.addQuery _prompt \(Agent.Inquiry {promptString} k) -> do
--     let prompt = Chat.userMessage promptString
--     history <- gets _.history
--     -- append prompt message to history
--     st <- modify \st -> st {history = st.history `Array.snoc` prompt}
--     -- reply
--     reply <- config.reply $ NonEmptyArray.snoc' history prompt
--     -- append reply to history
--     modify_ \st' -> st' {history = st.history `Array.snoc` reply}
--     -- yield reply
--     pure $ k reply) >>>
--   (Agent.addQuery _getHistory \(Agent.Inquiry _ k) -> 
--     k <$> gets _.history)

-- new cls input states = Agent.new cls $ 
--   R.union
--     { history: case input.system of
--         Nothing -> input.history
--         Just str -> [Chat.systemMessage str] <> input.history }
--     states

-- _prompt = Proxy :: Proxy "prompt"
-- prompt promptString = Agent.ask $ Agent.makeAsk _prompt {promptString}

-- _getHistory = Proxy :: Proxy "getHistory"
-- getHistory = Agent.ask $ Agent.makeAsk _getHistory unit
