module Main where

import Data.Options
import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Echo as Echo
import AI.Agent.Chat.GPT as GPT
import AI.Agent.CommandLine as CommandLine
import AI.Agent.Manager as Manager
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (ExceptT, runExceptT)
import Control.Monad.State (runStateT)
import Control.Plus (empty)
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Dotenv as Dotenv
import Effect as Effect
import Effect.Aff as Aff
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Class.Console as Console
import Effect.Unsafe (unsafePerformEffect)
import Hole (hole)
import Node.Process as Process
import Node.ReadLine as ReadLine
import Type.Proxy (Proxy(..))

_start = Proxy :: Proxy "start"
_cl = Proxy :: Proxy "cl"
_chat = Proxy :: Proxy "chat"

manager client =
  
  Manager.new {agents: {cl, chat}} 
    (Agent.empty 
      # Agent.addQuery _start (\(Agent.Inquiry a k) -> do
        Console.log "[open]"
        Agent.expandAgentM_states' $ Manager.sub _cl $ CommandLine.open unit
        
        question <- Agent.expandAgentM_states' $ Manager.sub _cl $ CommandLine.question "Q: "
        answer <- Agent.expandAgentM_states' $ Manager.sub _chat $ Chat.prompt question
        Console.log $ "A: " <> answer.content

        question <- Agent.expandAgentM_states' $ Manager.sub _cl $ CommandLine.question "Q: "
        answer <- Agent.expandAgentM_states' $ Manager.sub _chat $ Chat.prompt question
        Console.log $ "A: " <> answer.content

        question <- Agent.expandAgentM_states' $ Manager.sub _cl $ CommandLine.question "Q: "
        answer <- Agent.expandAgentM_states' $ Manager.sub _chat $ Chat.prompt question
        Console.log $ "A: " <> answer.content

        Console.log "[close]"
        Agent.expandAgentM_states' $ Manager.sub _cl $ CommandLine.close unit
        pure (k a)))
    { interface: Nothing
    , history: [] }
  
  where
  
  cl =
    CommandLine.new
      (Agent.empty
        # CommandLine.define 
          { interfaceOptions:
            ReadLine.output := Process.stdout <>
            ReadLine.terminal := true })
      { history: [] }
  
  chat =
    Chat.new
      -- (Agent.empty 
      --   # Echo.define)
      (Agent.empty
        # GPT.define
          { chatOptions: ChatOpenAI.defaultChatOptions
          , client })
      { system: Nothing
      , history: [] }
      {}
      { interface: Nothing }

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  Dotenv.loadFile
  -- Console.logShow =<< liftEffect Process.getEnv
  client <- liftEffect $ ChatOpenAI.makeClient Nothing
  void $ runExceptT $ Agent.query (FV.inj _start (Agent.Inquiry unit identity)) (manager client)

{-
What's an innovative new discovery in programming languages theory?
-}