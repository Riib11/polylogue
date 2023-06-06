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
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (ExceptT, runExceptT)
import Control.Monad.State (runStateT)
import Control.Plus (empty)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Tuple (fst, snd)
import Data.Variant as V
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

main :: Effect.Effect Unit
main = do
  let cls = exampleManagerClass
  let inst = exampleManagerInst
  Console.log =<< (fst <$> Agent.pureRun (Agent.inquire _abc unit cls) inst)

_sub1 = Proxy :: Proxy "sub1"
_sub2 = Proxy :: Proxy "sub2"
_sub3 = Proxy :: Proxy "sub3"
_test = Proxy :: Proxy "test"
_abc = Proxy :: Proxy "abc"

exampleManagerClass :: forall m. Monad m => 
  Manager.Class 
    ( sub1 :: Agent.Inst () () (test :: Agent.Inquiry String String) m 
    , sub2 :: Agent.Inst () () (test :: Agent.Inquiry String String) m 
    , sub3 :: Agent.Inst () () (test :: Agent.Inquiry String String) m )
    ()
    () 
    (abc :: Agent.Inquiry Unit String)
    m
exampleManagerClass = Agent.empty
  # Agent.addQuery _abc \(Agent.Inquiry _ output) -> do
    aStr <- Manager.subInquire _sub1 _test "a"
    bStr <- Manager.subInquire _sub2 _test "b"
    cStr <- Manager.subInquire _sub3 _test "c"
    pure (output (aStr <> "\n" <> bStr <> "\n" <> cStr))

exampleManagerInst :: forall m. Monad m =>
  Manager.Inst 
    ( sub1 :: Agent.Inst () () (test :: Agent.Inquiry String String) m 
    , sub2 :: Agent.Inst () () (test :: Agent.Inquiry String String) m
    , sub3 :: Agent.Inst () () (test :: Agent.Inquiry String String) m )
    ()
    () 
    (abc :: Agent.Inquiry Unit String)
    m
exampleManagerInst = Agent.new exampleManagerClass
  {agents: 
    { sub1: newSubAgent "sub1"
    , sub2: newSubAgent "sub2"
    , sub3: newSubAgent "sub3" }}
  where
  newSubAgent name = 
    Agent.new 
      (Agent.empty 
        # Agent.addQuery _test 
          \(Agent.Inquiry input output) -> pure (output ("I am subagent " <> show name <> " and I was given input " <> show input)))
      {}

{-
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

-- What's an innovative new discovery in programming languages theory?
-}