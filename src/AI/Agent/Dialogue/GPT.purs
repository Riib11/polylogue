module AI.Agent.Dialogue.GPT where

import AI.Agent.Dialogue (DialogueAgent, DialogueQuery(..))
import Prelude

import AI.Agent as Agent
import AI.LLM.Chat (_chat)
import AI.LLM.Chat as Chat
import Control.Monad.Except (runExceptT, throwError)
import Control.Monad.State (gets, modify, modify_)
import Data.Array as Array
import Data.Either (Either(..))
import Data.Variant (inj)
import Effect.Aff.Class (class MonadAff)

gpt :: forall m errors. MonadAff m => 
  Chat.ChatConfig -> 
  DialogueAgent (chat :: Chat.ChatError | errors) m
gpt chatConfig = Agent.makeAgent case _ of
  Prompt prompt k -> do
    -- append prompt message to history
    st <- modify \st -> st {history = st.history `Array.snoc` prompt}
    -- run chat on history
    reply <- runExceptT (Chat.chat chatConfig st.history) >>= case _ of
      Left chatError -> throwError $ inj _chat chatError
      Right reply -> pure reply
    -- append reply to history
    modify_ \st' -> st' {history = st.history `Array.snoc` reply}
    -- yield reply
    pure $ k reply
  GetHistory k -> k <$> gets _.history

