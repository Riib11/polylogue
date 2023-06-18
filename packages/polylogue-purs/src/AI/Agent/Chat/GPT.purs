-- | A chat agent using OpenAI's GPT chat completion.
module AI.Agent.Chat.GPT where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.AgentInquiry (defineInquiry) as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (runExceptT)
import Data.Either (Either(..))
import Effect.Aff.Class (class MonadAff)

type States states = Chat.States states
type Errors errors = Chat.Errors (chat :: ChatOpenAI.Error | errors)
type Queries queries = Chat.Queries ChatOpenAI.Message queries

extend :: forall states errors queries m. 
  MonadAff m => 
  { chatOptions :: ChatOpenAI.ChatOptions
  , client :: ChatOpenAI.Client } -> 
  Agent.ExtensibleAgent (States states) (Errors errors) queries (Queries queries) m
extend params =
  Agent.defineInquiry Chat._chat \history ->
    runExceptT (ChatOpenAI.chat params history) >>= case _ of
      Left chatError -> Agent.throwError Chat._chat chatError
      Right reply -> pure reply
