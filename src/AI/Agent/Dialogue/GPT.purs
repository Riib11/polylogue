module AI.Agent.Dialogue.GPT where

import Prelude

import AI.Agent.Dialogue as Dialogue
import AI.LLM.Chat as Chat
import Control.Monad.Except (runExceptT, throwError)
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either (Either(..))
import Data.Variant (inj)
import Effect.Aff.Class (class MonadAff)

define :: forall m errors. MonadAff m => 
  Chat.Config -> 
  Dialogue.Agent (chat :: Chat.Error | errors) m
define config = Dialogue.define \history -> do
  -- run chat on history
  runExceptT (Chat.chat config (NonEmptyArray.toArray history)) >>= case _ of
    Left chatError -> throwError $ inj Chat._chat chatError
    Right reply -> pure reply
