module AI.Agent 
  ( Agent, M, define
  , Id
  , new, query, ask, tell )
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
  Agent (forall a. query a -> M state errors m a)

type M state errors m = StateT state (ExceptT (Variant errors) m)

define = Agent

-- runAgent (Agent f) = f

--
-- agent instances
--

newtype
  Id
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type) 
    (m :: Type -> Type)
  = 
  Id UUID

derive newtype instance Eq (Id state errors query m)
derive newtype instance Ord (Id state errors query m)

foreign import newAgent :: forall state errors query m. 
  Agent state errors query m ->
  state ->
  Id state errors query m

new = newAgent

foreign import getAgent :: forall state errors query m. 
  Id state errors query m ->
  Agent state errors query m

foreign import getAgentState :: forall state errors query m.
  Id state errors query m ->
  state

foreign import setAgentState :: forall state errors query m.
  Id state errors query m ->
  state ->
  Unit

--
-- querying agents
--

query :: forall state errors query m a. Monad m =>
  Id state errors query m ->
  query a ->
  ExceptT (Variant errors) m a
query agent_id q = do
  -- get agent, input, and current state
  let Agent handleQuery = getAgent agent_id
  let state = getAgentState agent_id
  -- run agent query
  a /\ state' <- flip runStateT state $ handleQuery q
  -- update state
  let _ = setAgentState agent_id state'
  pure a

ask agent_id f = query agent_id (f identity)

tell agent_id f = void $ query agent_id (f unit)
