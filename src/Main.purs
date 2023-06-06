module Main where

import Data.Options
import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.Echo as Echo
import AI.Agent.Chat.GPT as GPT
import AI.Agent.Chat.Memory as Memory
import AI.Agent.Chat.Memory.Verbatim as Verbatim
import AI.Agent.Chat.WithMemory as ChatWithMemory
import AI.Agent.CommandLine as CommandLine
import AI.Agent.Manager as Manager
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (ExceptT, runExceptT)
import Control.Monad.State (gets, runStateT)
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
import Partial.Unsafe (unsafePartial)
import Type.Proxy (Proxy(..))

-- | Example: ChatWithMemory
_test = Proxy :: Proxy "test"

type Message = String

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  let

    cls :: ChatWithMemory.Class Message (history :: _) () () () () () _ _ _ Aff.Aff
    cls = Agent.define ChatWithMemory.define

    inst = Agent.new cls
      {agents: 
        { chat: Agent.new (Agent.define $ Echo.define {default: "error: empty history"}) {}
        , memory: Memory.new (Agent.define $ Verbatim.define) {} }}

    prog = do
      response <- cls#Chat.chat ["A"]
      Console.log response
      response <- cls#Chat.chat ["B"]
      Console.log response
      response <- cls#Chat.chat ["C"]
      Console.log response
      history <- cls#ChatWithMemory.getHistory
      Console.logShow history
      pure unit
  
  void (unsafePartial (Agent.partialRun prog inst))
  pure unit

{-
-- Example: command line
main :: Effect.Effect Unit
main = Aff.launchAff_ do
  let
    cls = 
      Agent.define $ 
        CommandLine.define
          {interfaceOptions: 
            ReadLine.output := Process.stdout <>
            ReadLine.terminal := true }
    inst =
      CommandLine.new cls {}
    prog = do
      CommandLine.open cls
      void $ cls#CommandLine.question "name: "
      void $ cls#CommandLine.question "age: "
      void $ cls#CommandLine.question "occupation: "
      CommandLine.close cls
      pure unit
  void (unsafePartial (Agent.partialRun prog inst))
  pure unit
-}

{-
-- Example: manager
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
exampleManagerClass = Agent.define $
  Agent.addQuery _abc \(Agent.Inquiry _ output) -> do
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
-}

