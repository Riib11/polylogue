module Test.AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import AI.Agent.Dialogue as Dialogue
import AI.Agent.Dialogue.Echo as Echo
import AI.Agent.Dialogue.GPT as GPT
import AI.Agent.Master as Master
import API.Chat.OpenAI as Chat
import Control.Plus (empty)
import Data.Functor.Variant as FV
import Data.Traversable (for_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console as Console
import Text.Pretty (indent)
import Type.Proxy (Proxy(..))

master :: forall m. 
  Monad m => MonadEffect m => MonadAff m => 
  Master.Agent () (chat :: Chat.Error) () m
master = Master.define FV.case_ \_ -> do
  let _states = Proxy :: Proxy ()

  let state = 
        { history: []
        , system: empty }

  -- echo
  let 
    dialogue_id :: GPT.Id () () m
    dialogue_id = Dialogue.new Echo.define state {}

  -- -- gpt
  -- dialogue_id :: GPT.Id () () m <- do
  --   client <- liftEffect $ Chat.makeClient empty
  --   let chatOptions = Chat.defaultChatOptions
  --   pure $ Dialogue.new (GPT.define {client, chatOptions}) state {}
  
  _ <- Agent.lift $ Agent.ask dialogue_id $ Dialogue.prompt $ Chat.userMessage
    "What's an interesting aspect of programming language theory?"

  Agent.lift $ void $ Agent.ask dialogue_id $ Dialogue.prompt $ Chat.userMessage
    "Write a short poem about that idea. Make sure it rhymes."

  do
    history <- Agent.lift $ Agent.ask dialogue_id $ Dialogue.getHistory
    for_ history \{role: Chat.Role role, content} -> 
      Console.log $ "[" <> role <> "]\n" <> indent content
  
  pure unit  

