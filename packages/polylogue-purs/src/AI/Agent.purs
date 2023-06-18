module AI.Agent where

import Prelude

import Control.Monad.Error.Class (class MonadThrow)
import Control.Monad.Error.Class as Error
import Control.Monad.Except (class MonadError, class MonadTrans, ExceptT, lift, runExceptT)
import Control.Monad.Reader (ReaderT, ask)
import Control.Monad.State (class MonadState, StateT, runStateT)
import Data.Either (Either(..))
import Data.Either.Nested (type (\/))
import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Data.Tuple.Nested (type (/\), (/\))
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Prim.Row (class Cons, class Nub, class Union)
import Record as R
import Type.Proxy (Proxy)
import Unsafe.Coerce (unsafeCoerce)

--------------------------------------------------------------------------------
-- Agent
--------------------------------------------------------------------------------

type States (states :: Row Type) = states
type Errors (errors :: Row Type) = errors
type Queries (queries :: Row (Type -> Type)) = queries

-- | An agent specification.
data
  Agent
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type) =
  Agent
    (forall a. QueryHandler states errors queries m a)

-- | An extensible agent class
type 
  ExtensibleAgent states errors queries_ queries m =
    Agent states errors queries_ m ->
    Agent states errors queries m

type 
  QueryHandler states errors queries m a = 
    QueryInput queries a -> AgentM states errors m a

type QueryInput queries a = FV.VariantF queries a

empty = Agent FV.case_

type QueryF states errors queries m =
  ReaderT (Agent states errors queries m) 
    (AgentM states errors m)

query :: forall label q states errors queries_ queries m a. IsSymbol label => Cons label q queries_ queries => Functor q => Monad m => Proxy label -> q a -> QueryF states errors queries m a
query label q = do
  Agent handleQuery <- ask
  lift (handleQuery (FV.inj label q))

defineQuery :: forall states errors query queryLabel queries_ queries m. IsSymbol queryLabel => Cons queryLabel query queries_ queries => Proxy queryLabel -> (forall a. query a -> AgentM states errors m a) -> ExtensibleAgent states errors queries_ queries m
defineQuery label handler (Agent subHandler) = Agent (FV.case_
  # const subHandler
  # FV.on label handler)

overrideQuery :: forall states errors query query' queryLabel queries_ queries queries' m. IsSymbol queryLabel => Cons queryLabel query queries_ queries => Cons queryLabel query' queries_ queries' => Monad m => Functor query => Proxy queryLabel -> ((forall a. query a -> AgentM states errors m a) -> (forall a'. query' a' -> AgentM states errors m a')) -> Agent states errors queries m -> Agent states errors queries' m
overrideQuery label overrideHandler (Agent subHandler) = Agent (FV.case_
  # const (subHandler <<< unsafeCoerce)
  # FV.on label (overrideHandler (subHandler <<< (FV.inj label))))

--------------------------------------------------------------------------------
-- AgentM
--------------------------------------------------------------------------------

newtype 
  AgentM
    (states :: Row Type)
    (errors :: Row Type)
    (m :: Type -> Type)
    (a :: Type)
  =
  AgentM 
    (ExceptT (V.Variant errors) (StateT (Record states) m) a)

derive newtype instance Functor m => Functor (AgentM states errors m)
derive newtype instance Monad m => Apply (AgentM states errors m)
derive newtype instance Monad m => Applicative (AgentM states errors m)
derive newtype instance Monad m => Bind (AgentM states errors m)
derive newtype instance Monad m => Monad (AgentM states errors m)
derive newtype instance MonadEffect m => MonadEffect (AgentM states errors m)
derive newtype instance MonadAff m => MonadAff (AgentM states errors m)
derive newtype instance Monad m => MonadState (Record states) (AgentM states errors m)
derive newtype instance Monad m => MonadThrow (V.Variant errors) (AgentM states errors m)
derive newtype instance Monad m => MonadError (V.Variant errors) (AgentM states errors m)

instance MonadTrans (AgentM states errors) where
  lift = lift >>> lift >>> AgentM

type Runner states errors m a =
  AgentM states errors m a -> 
  m ((V.Variant errors \/ a) /\ Record states)

run :: forall states errors m a. Record states -> Runner states errors m a
run states (AgentM m) = (runExceptT >>> flip runStateT states) m

catchingRun k states agent = run states agent >>= case _ of
  Left err /\ states -> k (err /\ states)
  Right a /\ states -> pure a


type Initialization (states :: Row Type) m = m (Record states)

init :: forall states m. Applicative m => Record states -> Initialization states m
init = pure

type ExtensibleInitialization states2 states3 m = Record states2 -> m (Record states3)

extendInit :: forall states1 states2 states3 m.
  Union states1 states2 states3 =>
  Nub states3 states3 =>
  Applicative m =>
  Record states1 ->
  ExtensibleInitialization states2 states3 m
extendInit states1 states2 = init (R.merge states1 states2)

throwError :: forall label states error errors' errors m a.
  IsSymbol label => Cons label error errors' errors =>
  Monad m =>
  Proxy label -> error ->
  AgentM states errors m a
throwError label = V.inj label >>> Error.throwError

-- !TODO try to avoid using these -- just define stuff with extensible rows
-- already

{-
expandAgentM_states :: forall states1 states2 states errors m a. 
  Monad m =>
  Union states1 states2 states =>
  Proxy states2 ->
  AgentM states1 errors m a ->
  AgentM states errors m a
expandAgentM_states _ m = AgentM do
  states <- get
  res /\ states' <- (lift >>> lift) (run (Coerce.unsafeCoerce states) m)
  -- Leaves `states1` untouched, and overwrites `state2` with the result
  -- state from `m`
  put $ UnsafeUnion.unsafeUnion states states'
  case res of
    Left err -> Error.throwError err
    Right a -> pure a

expandAgentM_errors :: forall states errors1 errors2 errors queries m a.
  Monad m =>
  Union errors1 errors2 errors =>
  Proxy errors2 ->
  AgentM states errors1 m a ->
  AgentM states errors m a
expandAgentM_errors _ m = AgentM do
  states <- get
  res /\ states' <- (lift >>> lift) (run (Coerce.unsafeCoerce states) m)
  -- Leaves `states1` untouched, and overwrites `state2` with the result
  -- state from `m`
  put $ UnsafeUnion.unsafeUnion states states'
  case res of
    Left err -> Error.throwError (V.expand err)
    Right a -> pure a

expandAgentM :: forall states1 states2 states errors1 errors2 errors m a.
  Monad m =>
  Union states1 states2 states =>
  Union errors1 errors2 errors =>
  Proxy states2 -> Proxy errors2 ->
  AgentM states1 errors1 m a ->
  AgentM states errors m a
expandAgentM proxy_states proxy_errors = 
  expandAgentM_states proxy_states >>> 
  expandAgentM_errors proxy_errors
-}

--------------------------------------------------------------------------------
-- MonadAgentEnv
--------------------------------------------------------------------------------

-- -- | `agentStates` is a record of the subagent states, where each subagent has a
-- -- | unique label in this record.
-- class 
--   ( MonadState (Record agentStates) m 
--   , MonadError (V.Variant errors) m) <=
--   MonadAgentEnv agentStates errors m

-- subQuery :: forall label agentStates states errors queries m a.
--   Monad m =>
--   IsSymbol label =>
--   -- Cons label _ queries_ queries  =>
--   Cons label agent (AgentM states errors m) states  =>
--   MonadAgentEnv agentStates errors m =>
--   Proxy label -> 
--   -- AgentM states errors m a ->
--   _ ->
--   m a
-- subQuery label input = do
--   agent /\ states <- gets (R.get label)
--   -- lift (run states (query input agent)) >>= case _ of
--   --   _ -> ?a
--   ?a

--   -- agents <- get
--   -- case V.project input agents of
--   --   Left err -> Error.throwError err
--   --   Right a -> pure a