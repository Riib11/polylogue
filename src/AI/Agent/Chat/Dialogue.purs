-- | And agent that manages a dialogue between two chat agents.
module AI.Agent.Chat.Dialogue where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.Agent.Control.Main as Main
import AI.Agent.Control.Manager as Manager
import AI.AgentInquiry as Agent
import Data.Maybe (Maybe(..))
import Type.Proxy (Proxy(..))

_agent1 = Proxy :: Proxy "agent1"
_agent2 = Proxy :: Proxy "agent2"

type States chatStates1 chatStates2 states = 
  Main.States 
    (Manager.States 
      ( agent1 :: Record chatStates1
      , agent2 :: Record chatStates2 )
      states)

type Errors errors = Main.Errors (Manager.Errors errors)

type Queries queries = Main.Queries (Manager.Queries queries)

extend :: forall msg chatStates1 chatQueries1 chatStates2 chatQueries2 states errors queries m.
  Monad m =>
  { agent1 :: Agent.Agent chatStates1 errors (Chat.Queries msg chatQueries1) m
  , agent2 :: Agent.Agent chatStates2 errors (Chat.Queries msg chatQueries2) m
  , setup :: Agent.AgentM (States chatStates1 chatStates2 states) (Errors errors) m Unit
  , cleanup :: Agent.AgentM (States chatStates1 chatStates2 states) (Errors errors) m Unit
  -- | Initial reply given from agent 2 to agent 1.
  , initialReply2 :: msg
  -- | Process a message from agent 1 to agent 2.
  , processMessageFrom1To2 :: msg -> Agent.AgentM (States chatStates1 chatStates2 states) (Errors errors) m (Maybe msg)
  -- | Process a message from agent 2 to agent 1.
  , processMessageFrom2To1 :: msg -> Agent.AgentM (States chatStates1 chatStates2 states) (Errors errors) m (Maybe msg) } ->
  Agent.ExtensibleAgent (States chatStates1 chatStates2 states) (Errors errors) queries (Queries queries) m
extend params =
  Main.extend \_ -> do
    params.setup
    
    let 
      loop Nothing = pure Nothing
      loop (Just reply1) = do
        Manager.subDo params.agent2 _agent2 (Chat.chat [reply1]) >>= params.processMessageFrom2To1 >>= case _ of
          Nothing -> pure Nothing
          Just reply2 -> do
            Manager.subDo params.agent1 _agent1 (Chat.chat [reply2]) >>= params.processMessageFrom1To2 >>= case _ of
              Nothing -> pure Nothing
              Just reply1' -> loop (Just reply1')

    reply1 <- Manager.subDo params.agent1 _agent1 $ Chat.chat [params.initialReply2]
    params.processMessageFrom1To2 reply1 >>= case _ of
      Nothing -> pure unit
      Just reply1' -> do
        void $ loop (Just reply1')
        pure unit
    
    params.cleanup