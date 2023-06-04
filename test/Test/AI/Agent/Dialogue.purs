module Test.AI.Agent.Chat where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Echo as Echo
import AI.Agent.Chat.GPT as GPT
import AI.Agent.Master as Master
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Error.Class (class MonadError)
import Control.Plus (empty)
import Data.Functor.Variant as FV
import Data.Traversable (for_)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console as Console
import Text.Pretty (indent)
import Type.Proxy (Proxy(..))

-- master :: forall m. 
--   Monad m => MonadEffect m => MonadAff m => MonadError (V.Variant (Chat.)) 
--   Master.Agent () (chat :: Chat.Error) () m
master = Master.define \_ -> do
  let _states = Proxy :: Proxy ()

  let state = 
        { history: []
        , system: empty }

  -- -- echo
  -- let 
  --   echo_id :: Chat.Id () () () _
  --   echo_id = Chat.new Echo.define state {}

  -- gpt
  gpt_id :: GPT.Id () () _ <- do
    client <- liftEffect $ ChatOpenAI.makeClient empty
    let chatOptions = ChatOpenAI.defaultChatOptions
    pure $ Chat.new (GPT.define {client, chatOptions}) state {}

  let dialogue_id = gpt_id
  
  _ <- Agent.lift $ Agent.ask dialogue_id $ Chat.prompt $ ChatOpenAI.userMessage
    "What's an interesting aspect of programming language theory?"

  Agent.lift $ void $ Agent.ask dialogue_id $ Chat.prompt $ ChatOpenAI.userMessage
    "Write a short poem about that idea. Make sure it rhymes."

  do
    history <- Agent.lift $ Agent.ask dialogue_id $ Chat.getHistory
    for_ history \{role: ChatOpenAI.Role role, content} -> 
      Console.log $ "[" <> role <> "]\n" <> indent content
  
  pure unit  

