module AI.Agent.Dialogue.GPT where

import AI.Agent.Dialogue
import Prelude

import AI.Agent (Agent(..))
import AI.LLM.Chat as Chat
import Control.Monad.Except (runExceptT)
import Control.Monad.State (gets, modify, modify_)
import Data.Array as Array
import Data.Either (Either(..))
import Effect.Aff.Class (class MonadAff)

type GPTDialogueAgent errors m = DialogueAgent (chat :: Chat.ChatError | errors) m

gpt :: forall m errors. MonadAff m => GPTDialogueAgent errors m
gpt = Agent case _ of
  Prompt prompt k -> do
    st <- modify \st -> st {history = st.history `Array.snoc` prompt}
    reply <- runExceptT (Chat.chat ?a st.history) >>= case _ of
      Left err -> ?a
      Right reply -> pure reply
    modify_ \st' -> st' {history = st.history `Array.snoc` reply}
    pure $ k reply
  GetHistory k -> k <$> gets _.history
