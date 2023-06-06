module AI.Agent where

import Data.Either
import Data.Tuple.Nested
import Prelude

import Control.Monad.Error.Class (class MonadThrow, throwError)
import Control.Monad.Except (class MonadError, class MonadTrans, ExceptT, lift, runExceptT)
import Control.Monad.Reader (ReaderT)
import Control.Monad.State (class MonadState, StateT, get, put, runStateT)
import Data.Functor.Variant as FV
import Data.Symbol (class IsSymbol)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Hole (hole)
import Prim.Row (class Cons, class Union)
import Record as R
import Type.Proxy (Proxy)

-- | An agent class.
data
  Class
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type) =
  Class 
    (forall a. QueryHandler states errors queries m a)

-- | An extensible agent class
type 
  Class' states errors queries_ queries m =
    Class states errors queries_ m ->
    Class states errors queries m

type 
  QueryHandler states errors queries m a = 
    QueryInput queries a -> AgentM states errors m a

type QueryInput queries a = FV.VariantF queries a

query input (Class handleQuery) = handleQuery input

empty = Class FV.case_

addQuery :: forall states errors query queryLabel queries_ queries m.
  IsSymbol queryLabel =>
  Cons queryLabel query queries_ queries =>
  Proxy queryLabel ->
  (forall a. query a -> AgentM states errors m a) ->
  Class' states errors queries_ queries m
addQuery label handler (Class subHandler) = Class (FV.case_
  # const subHandler
  # FV.on label handler)

-- | An agent class instance
data 
  Inst
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type) =
  Inst
    (Class states errors queries m)
    (Record states)

new = Inst

run m (Inst cls states) = runAgentM states m

pureRun m (Inst cls states) = runAgentM states m >>= case _ of
  Left err -> V.case_ err
  Right res -> pure res

-- | AgentM

newtype 
  AgentM
    (states :: Row Type)
    (errors :: Row Type)
    (m :: Type -> Type)
    (a :: Type)
  =
  AgentM 
    (StateT (Record states) (ExceptT (V.Variant errors) m) a)

derive newtype instance Functor m => Functor (AgentM states errors m)
derive newtype instance Monad m => Apply (AgentM states errors m)
derive newtype instance Monad m => Applicative (AgentM states errors m)
derive newtype instance Monad m => Bind (AgentM states errors m)
derive newtype instance Monad m => Monad (AgentM states errors m)
derive newtype instance MonadEffect m => MonadEffect (AgentM states errors m)
derive newtype instance MonadAff m => MonadAff (AgentM states errors m)

instance MonadTrans (AgentM states errors) where
  lift = lift >>> lift >>> AgentM

derive newtype instance Monad m => MonadState (Record states) (AgentM states errors m)
derive newtype instance Monad m => MonadThrow (V.Variant errors) (AgentM states errors m)
derive newtype instance Monad m => MonadError (V.Variant errors) (AgentM states errors m)

runAgentM states (AgentM m) = flip runStateT states >>> runExceptT $ m

throwExpandedError = throwError <<< V.expand

-- !TODO try to avoid using these -- just define stuff with extensible rows
-- already

-- expandAgentM_states :: forall states1 states2 states errors m a. 
--   Monad m =>
--   Union states1 states2 states =>
--   Proxy states1 ->
--   AgentM states2 errors m a ->
--   AgentM states errors m a
-- expandAgentM_states _ m = AgentM do
--   states <- get
--   (lift >>> lift $ runAgentM (Coerce.unsafeCoerce states) m) >>= case _ of
--     Left err -> throwError err
--     Right (a /\ states') -> do
--       -- Leaves `states1` untouched, and overwrites `state2` with the result
--       -- state from `m`
--       put $ UnsafeUnion.unsafeUnion states' states
--       pure a

-- expandAgentM_errors :: forall states errors1 errors2 errors queries m a.
--   Monad m =>
--   Union errors1 errors2 errors =>
--   Proxy errors2 ->
--   AgentM states errors1 m a ->
--   AgentM states errors m a
-- expandAgentM_errors _ m = AgentM do
--   states <- get
--   (lift >>> lift $ runAgentM states m) >>= case _ of
--     Left err -> throwError $ V.expand err
--     Right (a /\ states') -> do
--       put states'
--       pure a

-- -- expandAgentM :: forall states1 states2 states errors1 errors2 errors queries m a.
-- --   Monad m =>
-- --   Union states1 states2 states =>
-- --   Union errors1 errors2 errors =>
-- --   AgentM states1 errors1 queries m a ->
-- --   AgentM states errors queries m a
-- expandAgentM proxy_states proxy_errors = 
--   expandAgentM_states proxy_states >>> 
--   expandAgentM_errors proxy_errors
