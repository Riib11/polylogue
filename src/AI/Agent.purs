module AI.Agent where

import Data.Either
import Data.Either.Nested
import Data.Tuple.Nested
import Prelude

import Control.Bug (bug)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Error.Class as Error
import Control.Monad.Except (class MonadError, class MonadTrans, ExceptT, lift, runExceptT)
import Control.Monad.Morph (class MFunctor, class MMonad, embed, hoist)
import Control.Monad.Reader (ReaderT)
import Control.Monad.State (class MonadState, StateT, get, gets, put, runStateT)
import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Data.Variant as V
import Debug as Debug
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Hole (hole)
import Prim.Row (class Cons, class Union)
import Record as R
import Record.Unsafe.Union as UnsafeUnion
import Type.Proxy (Proxy)
import Unsafe.Coerce as Coerce

--------------------------------------------------------------------------------
-- Agent
--------------------------------------------------------------------------------

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

query input (Agent handleQuery) = handleQuery input

defineQuery :: forall states errors query queryLabel queries_ queries m.
  IsSymbol queryLabel =>
  Cons queryLabel query queries_ queries =>
  Proxy queryLabel ->
  (forall a. query a -> AgentM states errors m a) ->
  ExtensibleAgent states errors queries_ queries m
defineQuery label handler (Agent subHandler) = Agent (FV.case_
  # const subHandler
  # FV.on label handler)

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

runAgentM states (AgentM m) = (runExceptT >>> flip runStateT states) m

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
  res /\ states' <- (lift >>> lift) (runAgentM (Coerce.unsafeCoerce states) m)
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
  res /\ states' <- (lift >>> lift) (runAgentM (Coerce.unsafeCoerce states) m)
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
--   -- lift (runAgentM states (query input agent)) >>= case _ of
--   --   _ -> ?a
--   ?a

--   -- agents <- get
--   -- case V.project input agents of
--   --   Left err -> Error.throwError err
--   --   Right a -> pure a