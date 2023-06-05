module AI.Agent 
  ( Agent, M, define
  , trivial
  , Id
  , new, query, ask, tell 
  , expandErrors, lift )
  where

import Data.Either.Nested
import Prelude

import Control.Bug (bug)
import Control.Monad.Except (class MonadError, ExceptT, runExceptT, throwError)
import Control.Monad.State (StateT, runStateT)
import Control.Monad.Trans.Class as Trans
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Data.UUID (UUID)
import Data.Variant as V
import Data.Variant.Internal (class VariantTags)
import Prim.Row (class Nub, class Union)
import Prim.RowList (class RowToList)
import Type.Proxy (Proxy(..))

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
define :: forall states errors queries m. 
  (forall a. FV.VariantF queries a -> StateT (Record states) (ExceptT (V.Variant errors) m) a) ->
  Agent states errors queries m
define = Agent

trivial :: forall states errors m. Agent states errors () m
trivial = define FV.case_

{-
TODO: I do want this, but probably just have to do it unsafely becaues its 
infeasible to use these types


partitionVariantF :: forall row1 row1list row2 row2list row3 a.
  RowToList row1 row1list =>
  VariantTags row1list =>
  Union row1 row2 row3 =>
  RowToList row2 row2list =>
  VariantTags row2list =>
  Union row2 row1 row3 =>
  Nub row3 row3 =>
  Proxy row1 ->
  Proxy row2 ->
  FV.VariantF row3 a ->
  FV.VariantF row1 a \/ FV.VariantF row2 a
partitionVariantF _ _ v3 = case FV.contract v3 :: Maybe (FV.VariantF row1 a) of
  Just v1 -> Left v1
  Nothing -> case FV.contract v3 :: Maybe (FV.VariantF row2 a) of
    Just v2 -> Right v2
    Nothing -> bug "partitionVariantF: impossible"

union :: forall 
  states1 errors1 queries1 queriesList1
  states2 errors2 queries2 queriesList2
  states3 errors3 queries3 queriesList3
  m.
  Union errors1 errors2 errors3 =>
  Union states1 states2 states3 =>
  Nub states3 states3 =>
  Union queries1 queries2 queries3 =>
  Union queries2 queries1 queries3 =>
  RowToList queries1 queriesList1 =>
  RowToList queries2 queriesList2 =>
  RowToList queries3 queriesList3 =>
  VariantTags queriesList1 =>
  VariantTags queriesList2 =>
  VariantTags queriesList3 =>
  Nub queries3 queries3 =>
  Agent states1 errors1 queries1 m ->
  Agent states2 errors2 queries2 m ->
  Agent states3 errors3 queries3 m
union agent1 agent2 = define \query -> do
  let p_qs1 = Proxy :: Proxy queries1
  let p_qs2 = Proxy :: Proxy queries2
  case partitionVariantF p_qs1 p_qs2 query of
    Left query1 -> ?a
    Right query2 -> ?a
-}

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
-- | instance's id.
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
  MonadError (V.Variant errors) m =>
  Id states errors queries m ->
  FV.VariantF queries a ->
  m a
query agent_id q = do
  -- get agent, input, and current states
  let Agent handleQuery = getAgent agent_id
  let states = getAgentState agent_id
  -- run agent query
  a /\ states' <- runExceptT (flip runStateT states (handleQuery q)) >>= case _ of
    Left err -> throwError err
    Right result -> pure result
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
ask agent_id f = query agent_id $ f identity

-- | Queries an agent with a "tell"-style query, which is a query that is
-- | intended to just prompt the agent and not get a result. For example:
-- | ```purescript
-- | data Query a = SetState String a
-- | 
-- | setState agent_id states = tell agent_id $ SetState states
-- | ```
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
