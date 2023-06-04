module AI.Agent 
  ( Agent, M, define
  , Id
  , new, query, ask, tell 
  , expandErrors, lift )
  where

import Prelude

import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Control.Monad.State (StateT, runStateT)
import Control.Monad.Trans.Class as Trans
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Tuple.Nested ((/\))
import Data.UUID (UUID)
import Data.Variant as V
import Prim.Row (class Union)

-- | An agent definition, `Agent` is parameterized by:
-- |  - `states` - the states of the agent
-- |  - `errors` - the errors that the agent can throw
-- |  - `queries` - the queries that the agent can handle
-- |  - `m` - the monad in which the agent runs
-- |
-- | An agent definition is defined by how the agent handles queries. Each
-- | instance of an agent, identified by an `Id`, has its own states and handles
-- | queries indepentently of other instances of the same agent.
newtype
  Agent
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type)
  =
  Agent (forall a. FV.VariantF queries a -> M states errors m a)

-- | `M` is an alias for the monad in an `Agent` handles queries.
type M states errors m = StateT (Record states) (ExceptT (V.Variant errors) m)

-- | Makes an agent definition.
define :: forall states errors queries m. (forall a. FV.VariantF queries a -> StateT (Record states) (ExceptT (V.Variant errors) m) a) -> Agent states errors queries m
define = Agent

-- | `Id` is the type of agent ids, which matching parameters to the agent it is
-- | an id for.
newtype
  Id
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type)) 
    (m :: Type -> Type)
  = 
  Id UUID

derive newtype instance Eq (Id states errors queries m)
derive newtype instance Ord (Id states errors queries m)

-- | Makes a new agent instance from an agent definition, and outputs the new
-- | instances' id.
new :: forall states errors queries m. Agent states errors queries m -> Record states -> Id states errors queries m
new = newAgent

foreign import newAgent :: forall states errors queries m. 
  Agent states errors queries m ->
  Record states ->
  Id states errors queries m

foreign import getAgent :: forall states errors queries m. 
  Id states errors queries m ->
  Agent states errors queries m

foreign import getAgentState :: forall states errors queries m.
  Id states errors queries m ->
  Record states

foreign import setAgentState :: forall states errors queries m.
  Id states errors queries m ->
  Record states ->
  Unit

-- | Sends a queries to an agent instance, and yields the result.
query :: forall states errors queries m a. Monad m =>
  Id states errors queries m ->
  FV.VariantF queries a ->
  ExceptT (V.Variant errors) m a
query agent_id q = do
  -- get agent, input, and current states
  let Agent handleQuery = getAgent agent_id
  let states = getAgentState agent_id
  -- run agent query
  a /\ states' <- flip runStateT states $ handleQuery q
  -- update states
  let _ = setAgentState agent_id states'
  pure a

-- | Queries an agent instance with an "ask"-style query, which is a query that
-- | is intended to just get a result from the agent. For example:
-- | ```purescript
-- | data Query a = GetState (String -> a)
-- | 
-- | getState agent_id = ask agent_id GetState
-- | ```
ask :: forall states errors queries m a. Monad m => Id states errors queries m -> ((a -> a) -> FV.VariantF queries a) -> ExceptT (V.Variant errors) m a
ask agent_id f = query agent_id $ f identity

-- | Queries an agent with a "tell"-style query, which is a query that is
-- | intended to just prompt the agent and not get a result. For example:
-- | ```purescript
-- | data Query a = SetState String a
-- | 
-- | setState agent_id states = tell agent_id $ SetState states
-- | ```
tell :: forall states errors queries m a. Monad m => Id states errors queries m -> (Unit -> FV.VariantF queries a) -> ExceptT (V.Variant errors) m Unit
tell agent_id f = void $ query agent_id (f unit)

-- | Expands the row type of errors that an agent can throw.
expandErrors :: forall errors0 errors1 errors2 m a.
  Union errors0 errors1 errors2 =>
  Monad m =>
  ExceptT (V.Variant errors0) m a ->
  ExceptT (V.Variant errors2) m a
expandErrors e = Trans.lift (runExceptT e) >>= case _ of
  Left err -> throwError (V.expand err)
  Right a -> pure a

lift :: forall states errors0 errors1 errors2 m a.
  Union errors0 errors1 errors2 =>
  Monad m =>
  ExceptT (V.Variant errors0) m a ->
  StateT (Record states) (ExceptT (V.Variant errors2) m) a
lift = Trans.lift <<< expandErrors
