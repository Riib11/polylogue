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

-- | An agent definition, `Agent` is parameterized by:
-- |  - `state` - the state of the agent
-- |  - `errors` - the errors that the agent can throw
-- |  - `query` - the query that the agent can handle
-- |  - `m` - the monad in which the agent runs
-- |
-- | An agent definition is defined by how the agent handles queries. Each
-- | instance of an agent, identified by an `Id`, has its own state and handles
-- | queries indepentently of other instances of the same agent.
newtype
  Agent
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type)
    (m :: Type -> Type)
  =
  Agent (forall a. query a -> M state errors m a)

-- | `M` is an alias for the monad in an `Agent` handles queries.
type M state errors m = StateT state (ExceptT (Variant errors) m)

-- | Makes an agent definition.
define :: forall state161 errors162 query163 m164. (forall a. query163 a -> StateT state161 (ExceptT (Variant errors162) m164) a) -> Agent state161 errors162 query163 m164
define = Agent

-- | `Id` is the type of agent ids, which matching parameters to the agent it is
-- | an id for.
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

-- | Makes a new agent instance from an agent definition, and outputs the new
-- | instances' id.
new :: forall state errors query m. Agent state errors query m -> state -> Id state errors query m
new = newAgent

foreign import newAgent :: forall state errors query m. 
  Agent state errors query m ->
  state ->
  Id state errors query m

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

-- | Sends a query to an agent instance, and yields the result.
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

-- | Queries an agent instance with an "ask"-style query, which is a query that
-- | is intended to just get a result from the agent. For example:
-- | ```purescript
-- | data Query a = GetState (String -> a)
-- | 
-- | getState agent_id = ask agent_id GetState
-- | ```
ask :: forall state errors query m a. Monad m => Id state errors query m -> ((a -> a) -> query a) -> ExceptT (Variant errors) m a
ask agent_id f = query agent_id $ f identity

-- | Queries an agent with a "tell"-style query, which is a query that is
-- | intended to just prompt the agent and not get a result. For example:
-- | ```purescript
-- | data Query a = SetState String a
-- | 
-- | setState agent_id state = tell agent_id $ SetState state
-- | ```
tell :: forall state errors query m a. Monad m => Id state errors query m -> (Unit -> query a) -> ExceptT (Variant errors) m Unit
tell agent_id f = void $ query agent_id (f unit)
