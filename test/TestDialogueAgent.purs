module Test.TestDialogueAgent where

import Prelude

import AI.Agent (Agent(..))
import AI.Agent as Agent
import AI.Agent.Dialogue (DialogueQuery(..))
import AI.Agent.Dialogue.Echo (echo)
import AI.Agent.Master (MasterAgent, Start(..))
import AI.LLM.Chat (Role(..))
import AI.LLM.Chat as Chat
import Control.Monad.Trans.Class (lift)
import Data.Maybe (Maybe(..))
import Data.Traversable (for, for_, traverse)
import Effect.Aff (Aff)
import Effect.Class.Console as Console
import Text.Pretty (indent)

master :: MasterAgent Aff
master = Agent case _ of
  Start a -> do
    let 
      bong_id = Agent.register echo
        {systemPrompt: Nothing}
        {history: []}
    
    lift <<< lift $ void $ Agent.ask bong_id $ Prompt $ Chat.userMessage
      "What's an interesting aspect of programming language theory?"

    lift <<< lift $ void $ Agent.ask bong_id $ Prompt $ Chat.userMessage
      "Write a short poem about that idea. Make sure it rhymes."

    do
      history <- lift <<< lift $ Agent.ask bong_id $ GetHistory
      for_ history \{role: Role role, content} -> 
        Console.log $ "[" <> role <> "]\n" <> indent content

    pure a
