module AI.Agent.Chat.GPT where

import Prelude

import AI.Agent.Chat as Chat
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (runExceptT, throwError)
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Variant (inj)
import Effect.Aff.Class (class MonadAff)

type Agent states errors m = Chat.Agent states (chat :: ChatOpenAI.Error | errors) () m
type Id states errors m = Chat.Id states (chat :: ChatOpenAI.Error | errors) () m

define :: forall m states errors. MonadAff m => 
  ChatOpenAI.Config -> 
  Agent states errors m
define config = Chat.define FV.case_ \history -> do
  -- run chat on history
  runExceptT (ChatOpenAI.chat config (NonEmptyArray.toArray history)) >>= case _ of
    Left chatError -> throwError $ inj Chat._chat chatError
    Right reply -> pure reply
