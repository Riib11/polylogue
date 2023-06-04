module AI.Agent.Dialogue.Echo where

import AI.Agent as Agent
import AI.Agent.Dialogue (DialogueAgent, DialogueQuery(..))
import Prelude
import AI.LLM.Chat as Chat
import Control.Monad.State (gets, modify_)
import Data.Array as Array

-- | A dialogue agent that echos the user's prompt.
echo :: forall m errors. Monad m => DialogueAgent errors m
echo = Agent.makeAgent case _ of
  Prompt prompt k -> do
    modify_ \st -> st {history = st.history `Array.snoc` prompt}
    let reply = Chat.assistantMessage prompt.content
    modify_ \st -> st {history = st.history `Array.snoc` reply}
    pure $ k reply
  GetHistory k -> k <$> gets _.history

