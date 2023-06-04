module AI.Agent 
  ( Agent, makeAgent
  , AgentId
  , register, query, ask, tell )
  where

import Prelude

import Control.Monad.Except (ExceptT)
import Control.Monad.State (StateT, runStateT)
import Data.Tuple.Nested ((/\))
import Data.UUID (UUID)
import Data.Variant (Variant)

--
-- agents
--

newtype
  Agent
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type)
    (m :: Type -> Type)
  =
  Agent (forall a. query a -> AgentM state errors m a)

type AgentM state errors m = StateT state (ExceptT (Variant errors) m)

makeAgent = Agent

runAgent (Agent f) = f

--
-- registering agents
--

newtype
  AgentId 
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type) 
    (m :: Type -> Type)
  = 
  AgentId UUID

derive newtype instance Eq (AgentId state errors query m)
derive newtype instance Ord (AgentId state errors query m)

foreign import register :: forall state errors query m. 
  Agent state errors query m ->
  state -> 
  AgentId state errors query m

foreign import getAgent :: forall state errors query m. 
  AgentId state errors query m ->
  Agent state errors query m

foreign import getAgentState :: forall state errors query m.
  AgentId state errors query m ->
  state

foreign import setAgentState :: forall state errors query m.
  AgentId state errors query m ->
  state ->
  Unit

--
-- querying agents
--

query :: forall state errors query m a. Monad m =>
  AgentId state errors query m ->
  query a ->
  ExceptT (Variant errors) m a
query agent_id q = do
  -- get agent, input, and current state
  let agent = getAgent agent_id
  let state = getAgentState agent_id
  -- run agent query
  a /\ state' <- flip runStateT state $ runAgent agent q
  -- update state
  let _ = setAgentState agent_id state'
  pure a

ask agent_id f = query agent_id (f identity)

tell agent_id f = void $ query agent_id (f unit)
