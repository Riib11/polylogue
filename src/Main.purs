module Main where

import Data.Options
import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Chat.CommandLine as CommandLine
import AI.Agent.Chat.Dialogue as Dialogue
import AI.Agent.Chat.Echo as Echo
import AI.Agent.Chat.GPT as GPT
import AI.Agent.Chat.Memory as Memory
import AI.Agent.Chat.Memory.Verbatim as Verbatim
import AI.Agent.Chat.WithMemory as ChatWithMemory
import AI.Agent.Control.Main as Main
import AI.Agent.Control.Manager as Manager
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Except (ExceptT, runExceptT)
import Control.Monad.Reader (runReaderT)
import Control.Monad.State (gets, runStateT)
import Control.Plus (empty)
import Data.Array as Array
import Data.Either (Either(..))
import Data.Foldable (for_)
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
import Text.Pretty (bullets)
import Type.Proxy (Proxy(..))

type Message = ChatOpenAI.Message
type Errors = GPT.Errors (CommandLine.Errors ())

--
-- dialogue
--

type Dialogue = Agent.Agent DialogueStates Errors (Dialogue.Queries ()) Aff.Aff
type DialogueStates = Dialogue.States UserStates AssistantStates ()

dialogue :: ChatOpenAI.Client -> Dialogue
dialogue client = Agent.empty
  # Dialogue.extend
      { agent1
      , agent2
      , setup: pure unit
      , cleanup: pure unit
      , initialReply2: ChatOpenAI.assistantMessage "I am the assistant."
      , processMessageFrom1To2: \msg -> pure (Just msg)
      , processMessageFrom2To1: \msg -> pure (Just msg) }
  # Agent.overrideInquiry Main._main \super _ -> do
      Manager.subDo agent1 Dialogue._agent1 CommandLine.open
      super unit
      Manager.subDo agent1 Dialogue._agent1 CommandLine.close
  where
    agent1 = user
    agent2 = assistant client

--
-- User
--

type User = Agent.Agent UserStates Errors UserQueries Aff.Aff
type UserStates = CommandLine.States ()
type UserQueries = CommandLine.Queries Message ()

user :: User
user = Agent.empty
  # CommandLine.extend
      { interfaceOptions: 
          ReadLine.output := Process.stdout <>
          ReadLine.terminal := true
    , parse: pure <<< ChatOpenAI.userMessage
    , makePrompt: \msgs -> do
        for_ msgs \msg -> Console.log $ "A: " <> msg.content
        pure "Q: " }

--
-- Assistant
--

type Assistant = Agent.Agent AssistantStates Errors AssistantQueries Aff.Aff
type AssistantStates = ChatWithMemory.States Message () () ()
type AssistantQueries = ChatWithMemory.Queries Message ()

assistant :: ChatOpenAI.Client -> Assistant
assistant client = Agent.empty
  # ChatWithMemory.extend
      { chat: Agent.empty
        # GPT.extend
            { client
            , chatOptions: ChatOpenAI.defaultChatOptions }
      , memory: Agent.empty
        # Verbatim.extend }

--
-- main
--

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  Dotenv.loadFile
  client <- liftEffect $ ChatOpenAI.makeClient Nothing
  userStates <- CommandLine.extendInit {}
  memoryStates <- Memory.extendInit {}
  Agent.catchingRun 
    (\(err /\ _states) -> Console.log $ "error: " <> show err)
    { allSubStates: 
        { agent1: userStates
        , agent2:
            { allSubStates:
                { chat: {} 
                , memory: memoryStates } } } }
    (Main.runMain (dialogue client))
  pure unit

{-
-- | Example: Manager, ChatWithMemory, CommandLine

_main = Proxy :: Proxy "main"
_start = Proxy :: Proxy "start"
_chat = Proxy :: Proxy "chat"
_user = Proxy :: Proxy "user"
_assistant = Proxy :: Proxy "assistant"

type Message = ChatOpenAI.Message
type Errors = CommandLine.Errors (GPT.Errors ())

type User = Agent.Agent (CommandLine.States ()) Errors (CommandLine.Queries ()) Aff.Aff
type UserStates = CommandLine.States ()

type Assistant = Agent.Agent AssistantStates Errors (ChatWithMemory.Queries Message ()) Aff.Aff
type AssistantStates = ChatWithMemory.States Message () () () () Errors () Aff.Aff

type Master = Agent.Agent MasterStates Errors (Manager.Queries (main :: Agent.Inquiry Unit Unit)) Aff.Aff
type MasterStates = Manager.States (user :: User, assistant :: Assistant) (user :: Record UserStates, assistant :: Record AssistantStates) ()

type MasterAllSubAgents = (user :: User, assistant :: Assistant)

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  Dotenv.loadFile
  client <- liftEffect $ ChatOpenAI.makeClient Nothing

  let
    user :: User
    user = Agent.empty 
      # CommandLine.extend 
          { interfaceOptions: 
              ReadLine.output := Process.stdout <>
              ReadLine.terminal := true }

  let 
    assistant :: Assistant
    assistant = Agent.empty # ChatWithMemory.extend

  let
    master :: Master
    master = Agent.empty #
      Agent.defineInquiry _main \_ -> do
        Manager.subDo _user $ CommandLine.open
        
        prompt <- Manager.subDo _user $ Chat.chat ["Q: "]
        logResponse $ Manager.subDo _assistant $ Chat.chat [ChatOpenAI.userMessage prompt]
        logResponse $ Manager.subDo _assistant $ Chat.chat [ChatOpenAI.userMessage "Explain that in more detail."]

        history <- Manager.subDo _assistant $ ChatWithMemory.getHistory
        Console.log $ "history:" <> (bullets (history <#> _.content))

        Manager.subDo _user $ CommandLine.close
      where
      logResponse = (_ >>= \response -> Console.log $ "A: " <> response.content)

  Agent.catchingRun (\(err /\ _states) -> Console.log $ "error: " <> show err)
    { allSubAgents: {assistant, user}
    , allSubStates:
        { user: {interface: Nothing} 
        , assistant:
            { allSubAgents:
                { chat: Agent.empty # GPT.extend {client, chatOptions: ChatOpenAI.defaultChatOptions}
                  -- Agent.empty # Echo.extend {default: "echo error: empty history"}
                , memory: Agent.empty # Verbatim.extend }
            , allSubStates:
                { chat: {}
                , memory: Memory.extendInit {} {} }} }
    }
    (runReaderT (Agent.inquire _main unit) master)

  pure unit
-}

{-
-- | Example: Manager, ChatWithMemory, CommandLine

_main = Proxy :: Proxy "main"
_start = Proxy :: Proxy "start"
_chat = Proxy :: Proxy "chat"
_user = Proxy :: Proxy "user"
_assistant = Proxy :: Proxy "assistant"

type Message = String
type Errors = CommandLine.Errors ()

type User = Agent.Agent (CommandLine.States ()) (CommandLine.Errors ()) (CommandLine.Queries ()) Aff.Aff
type UserStates = CommandLine.States ()

type Assistant = Agent.Agent AssistantStates (ChatWithMemory.Errors Errors) (ChatWithMemory.Queries Message ()) Aff.Aff
type AssistantStates = ChatWithMemory.States Message () () () () (commandLine :: CommandLine.Error) () Aff.Aff

type Master = Agent.Agent MasterStates (Manager.Errors Errors) (Manager.Queries (main :: Agent.Inquiry Unit Unit)) Aff.Aff
type MasterStates = Manager.States (user :: User, assistant :: Assistant) (user :: Record UserStates, assistant :: Record AssistantStates) ()

type MasterAllSubAgents = (user :: User, assistant :: Assistant)

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  let
    user :: User
    user = Agent.empty 
      # CommandLine.extend 
          { interfaceOptions: 
              ReadLine.output := Process.stdout <>
              ReadLine.terminal := true }

  let 
    assistant :: Assistant
    assistant = Agent.empty # ChatWithMemory.extend

  let
    master :: Master
    master = Agent.empty #
      Agent.defineInquiry _main \_ -> do
        Manager.subDo _user $ CommandLine.open
        
        prompt <- Manager.subDo _user $ Chat.chat ["Q: "]
        response <- Manager.subDo _assistant $ Chat.chat [prompt]
        Console.log $ "A: " <> response

        prompt <- Manager.subDo _user $ Chat.chat ["Q: "]
        response <- Manager.subDo _assistant $ Chat.chat [prompt]
        Console.log $ "A: " <> response

        prompt <- Manager.subDo _user $ Chat.chat ["Q: "]
        response <- Manager.subDo _assistant $ Chat.chat [prompt]
        Console.log $ "A: " <> response
        
        prompt <- Manager.subDo _user $ Chat.chat ["Q: "]
        response <- Manager.subDo _assistant $ Chat.chat [prompt]
        Console.log $ "A: " <> response

        history <- Manager.subDo _assistant $ ChatWithMemory.getHistory
        Console.log $ "history:" <> (bullets history)

        Manager.subDo _user $ CommandLine.close

  Agent.catchingRun (\(err /\ _states) -> Console.log $ "error: " <> show err)
    { allSubAgents: {assistant, user}
    , allSubStates:
        { user: {interface: Nothing} 
        , assistant:
            { allSubAgents:
                { chat: Agent.empty # Echo.extend {default: "echo error: empty history"}
                , memory: Agent.empty # Verbatim.extend }
            , allSubStates:
                { chat: {}
                , memory: Memory.extendInit {} {} }} }
    }
    (runReaderT (Agent.inquire _main unit) master)

  pure unit
-}

{-
-- | Example: Manager, ChatWithMemory, CommandLine

_test = Proxy :: Proxy "test"
_start = Proxy :: Proxy "start"
_chat = Proxy :: Proxy "chat"
_user = Proxy :: Proxy "user"
_assistant = Proxy :: Proxy "assistant"

type Message = String

type Errors = CommandLine.Errors ()

main :: Effect.Effect Unit
main = Aff.launchAff_ do
  let
    user = CommandLine.new cli {}
      where
      cli :: CommandLine.Class () () () Aff.Aff
      cli = Agent.define 
        (CommandLine.define
          { interfaceOptions: 
              ReadLine.output := Process.stdout <>
              ReadLine.terminal := true })

    assistant = Agent.new chat
      {agents: 
        { chat: Agent.new (Agent.define $ Echo.define {default: "error: empty history"}) {}
        , memory: Memory.new (Agent.define $ Verbatim.define) {} }}
      where
      chat :: ChatWithMemory.Class Message (history :: _) Errors () () () () _ _ _ Aff.Aff
      chat = Agent.define ChatWithMemory.define

    manager :: Manager.Class (user :: _, assistant :: _) () Errors (start :: _) Aff.Aff
    manager = Agent.define (Agent.addInquiry _start \_ -> do
      Manager.subInquire _user CommandLine._open unit
      prompt <- Manager.subInquire _user Chat._chat ["Q: "]
      response <- Manager.subInquire _
      
      -- response <- chat#Chat.chat ["A"]
      -- Console.log response
      -- response <- chat#Chat.chat ["B"]
      -- Console.log response
      -- response <- chat#Chat.chat ["C"]
      -- Console.log response
      
      -- history <- chat#ChatWithMemory.getHistory
      -- Console.logShow history
      
      Manager.subInquire _user CommandLine._close unit
      pure unit)

    master = Agent.new manager {agents: {user: user, assistant}}
  
  void do
    master#Agent.unsafeRun do
      manager#Agent.inquire _start unit
      pure unit

  pure unit
-}


{-
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
-}

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

