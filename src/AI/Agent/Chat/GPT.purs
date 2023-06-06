module AI.Agent.Chat.GPT where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat as Chat
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Error.Class (throwError)
import Control.Monad.Except (runExceptT)
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Effect.Aff.Class (class MonadAff)
import Type.Proxy (Proxy(..))

define config =
  Agent.addInquiry Chat._chat \history ->
    runExceptT (ChatOpenAI.chat config (NonEmptyArray.toArray history)) >>= case _ of
      Left chatError -> Agent.throwError Chat._chat chatError
      Right reply -> pure reply
