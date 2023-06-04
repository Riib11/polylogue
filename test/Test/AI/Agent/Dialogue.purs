module Test.AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import AI.Agent.Dialogue as Dialogue
-- import AI.Agent.Dialogue.Echo as Echo
import AI.Agent.Dialogue.GPT as GPT
import AI.Agent.Master as Master
import AI.LLM.Chat as Chat
import Control.Monad.Trans.Class (lift)
import Control.Plus (empty)
import Data.Traversable (for_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console as Console
import Text.Pretty (indent)

master :: forall state m. 
  Monad m => MonadEffect m => MonadAff m => 
  Master.Agent state (chat :: Chat.Error) m
master = Master.define \_ -> do
  let state = 
        { history: []
        , system: empty }

  -- echo
  -- let dialogue_id = Dialogue.new Echo.define state

  -- gpt
  dialogue_id <- do
    client <- liftEffect $ Chat.makeClient empty
    let chatOptions = Chat.defaultChatOptions
    pure $ Dialogue.new (GPT.define {client, chatOptions}) state
  
  lift $ void $ Agent.ask dialogue_id $ Dialogue.Prompt $ Chat.userMessage
    "What's an interesting aspect of programming language theory?"

  lift $ void $ Agent.ask dialogue_id $ Dialogue.Prompt $ Chat.userMessage
    "Write a short poem about that idea. Make sure it rhymes."

  do
    history <- lift $ Agent.ask dialogue_id $ Dialogue.GetHistory
    for_ history \{role: Chat.Role role, content} -> 
      Console.log $ "[" <> role <> "]\n" <> indent content
  
  pure unit  

