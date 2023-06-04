module AI.Agent.Dialogue.GPT where

import Prelude

import AI.Agent.Dialogue as Dialogue
import API.Chat.OpenAI as Chat
import Control.Monad.Except (runExceptT, throwError)
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either (Either(..))
import Data.Variant (inj)
import Effect.Aff.Class (class MonadAff)

type Agent states errors m = Dialogue.Agent states (chat :: Chat.Error | errors) m
type Id states errors m = Dialogue.Id states (chat :: Chat.Error | errors) m

define :: forall m states errors. MonadAff m => 
  Chat.Config -> 
  Agent states errors m
define config = Dialogue.define \history -> do
  -- run chat on history
  runExceptT (Chat.chat config (NonEmptyArray.toArray history)) >>= case _ of
    Left chatError -> throwError $ inj Chat._chat chatError
    Right reply -> pure reply
