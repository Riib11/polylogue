module AI.Agent.Chat.GPT where

import Prelude

import AI.Agent (throwError) as Agent
import AI.Agent.Chat as Chat
import AI.AgentInquiry (defineInquiry) as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (runExceptT)
import Data.Either (Either(..))
import Effect.Aff.Class (class MonadAff)

type ExtensibleAgent states errors queries m = Chat.ExtensibleAgent ChatOpenAI.Message states (Errors errors) queries m

type Errors errors = (chat :: ChatOpenAI.Error | errors)

extend :: forall states errors queries m. 
  MonadAff m => 
  { chatOptions :: ChatOpenAI.ChatOptions
  , client :: ChatOpenAI.Client } -> 
  Chat.ExtensibleAgent ChatOpenAI.Message states (Errors errors) queries m
extend params =
  Agent.defineInquiry Chat._chat \history ->
    runExceptT (ChatOpenAI.chat params history) >>= case _ of
      Left chatError -> Agent.throwError Chat._chat chatError
      Right reply -> pure reply
