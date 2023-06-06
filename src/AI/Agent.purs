module AI.Agent where

import Prelude

import Control.Monad.Error.Class (class MonadError, class MonadThrow, throwError)
import Control.Monad.Except (class MonadError, class MonadTrans, ExceptT, lift, runExceptT)
import Control.Monad.State (class MonadState, StateT, get, gets, modify_, put, runStateT)
import Data.Either (Either(..))
import Data.Either.Nested (type (\/))
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Data.Tuple.Nested (type (/\), (/\))
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Prim.Row (class Cons, class Union)
import Record as R
import Record.Unsafe.Union as UnsafeUnion
import Type.Proxy (Proxy(..))
import Unsafe.Coerce as Coerce

-- | Class

data
  Class
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type)
  =
  Class
    (forall a.
      FV.VariantF queries a -> 
      AgentM states errors m a)

runClass (Class handleQuery) = handleQuery

empty = Class FV.case_

addQuery :: forall states errors query queryLabel queries queries' m.
  IsSymbol queryLabel =>
  Cons queryLabel query queries queries' =>
  Proxy queryLabel ->
  (forall a. query a -> AgentM states errors m a) ->
  Class states errors queries m ->
  Class states errors queries' m
addQuery label handler (Class subHandler) = Class (FV.case_
  # (\_ -> subHandler)
  # FV.on label handler)

-- | Inst

data
  Inst
    (states :: Row Type)
    (errors :: Row Type)
    (queries :: Row (Type -> Type))
    (m :: Type -> Type)
  =
  Inst
    (Class states errors queries m)
    (Record states)

new cls states1 states2 = Inst cls $ R.union states1 states2

query :: forall states errors queries m a. 
  Monad m => MonadError (V.Variant errors) m =>
  FV.VariantF queries a ->
  Inst states errors queries m ->
  m (Inst states errors queries m /\ a)
query q (Inst cls states) =
  runAgentM states (runClass cls q) >>= case _ of
    Left err -> throwError err
    Right (a /\ states') -> do
      pure $ Inst cls states' /\ a

-- | Inquiry

data Inquiry input output a = Inquiry input (output -> a)
derive instance Functor (Inquiry input output)

makeInquiry label input output = FV.inj label $ Inquiry input output

inquiry label i = query <<< FV.inj label <<< Inquiry i

-- | Ask

makeAsk label input = FV.inj label <<< Inquiry input

ask :: forall states errors queries m a. 
  Monad m => MonadError (V.Variant errors) m =>
  ((forall b. b -> b) -> FV.VariantF queries a) ->
  Inst states errors queries m ->
  m (Inst states errors queries m /\ a)
ask f = query (f identity)

-- | Tell

makeTell label input = FV.inj label $ Inquiry input (const unit)

tell :: forall states errors queries m a.
  Monad m => MonadError (V.Variant errors) m =>
  (a -> FV.VariantF queries Unit) ->
  a ->
  Inst states errors queries m ->
  m (Inst states errors queries m /\ Unit)
tell f a = query (f a)

-- | AgentM

newtype 
  AgentM
    (states :: Row Type)
    (errors :: Row Type)
    (m :: Type -> Type)
    (a :: Type)
  =
  AgentM (StateT (Record states) (ExceptT (V.Variant errors) m) a)

derive newtype instance Functor m => Functor (AgentM states errors m)
derive newtype instance Monad m => Apply (AgentM states errors m)
derive newtype instance Monad m => Applicative (AgentM states errors m)
derive newtype instance Monad m => Bind (AgentM states errors m)
derive newtype instance Monad m => Monad (AgentM states errors m)
derive newtype instance MonadEffect m => MonadEffect (AgentM states errors m)
derive newtype instance MonadAff m => MonadAff (AgentM states errors m)

instance MonadTrans (AgentM states errors) where
  lift = AgentM <<< lift <<< lift

derive newtype instance Monad m => MonadState (Record states) (AgentM states errors m)
derive newtype instance Monad m => MonadThrow (V.Variant errors) (AgentM states errors m)
derive newtype instance Monad m => MonadError (V.Variant errors) (AgentM states errors m)

runAgentM :: forall states errors a m. 
  Record states ->
  AgentM states errors m a ->
  m (V.Variant errors \/ (a /\ Record states))
runAgentM states (AgentM m) = flip runStateT states >>> runExceptT $ m

-- !TODO try to avoid using these -- just define stuff with extensible rows
-- already

expandAgentM_states' :: forall states1 states2 states errors m a. 
  Monad m =>
  Union states1 states2 states =>
  AgentM states1 errors m a ->
  AgentM states errors m a
expandAgentM_states' m = AgentM do
  states <- get
  (lift >>> lift $ runAgentM (Coerce.unsafeCoerce states) m) >>= case _ of
    Left err -> throwError err
    Right (a /\ states') -> do
      put $ UnsafeUnion.unsafeUnion states' states
      pure a

expandAgentM_states :: forall states1 states2 states errors m a. 
  Monad m =>
  Union states1 states2 states =>
  Proxy states1 ->
  AgentM states2 errors m a ->
  AgentM states errors m a
expandAgentM_states _ m = AgentM do
  states <- get
  (lift >>> lift $ runAgentM (Coerce.unsafeCoerce states) m) >>= case _ of
    Left err -> throwError err
    Right (a /\ states') -> do
      -- Leaves `states1` untouched, and overwrites `state2` with the result
      -- state from `m`
      put $ UnsafeUnion.unsafeUnion states' states
      pure a

-- expandAgentM_errors :: forall states errors1 errors2 errors queries m a.
--   Monad m =>
--   Union errors1 errors2 errors =>
--   AgentM states errors1 queries m a ->
--   AgentM states errors queries m a
-- expandAgentM_errors m = AgentM do
--   states <- get
--   (lift >>> lift $ runAgentM states m) >>= case _ of
--     Left err -> throwError $ V.expand err
--     Right (a /\ states') -> do
--       put states'
--       pure a

-- expandAgentM :: forall states1 states2 states errors1 errors2 errors queries m a.
--   Monad m =>
--   Union states1 states2 states =>
--   Union errors1 errors2 errors =>
--   AgentM states1 errors1 queries m a ->
--   AgentM states errors queries m a
-- expandAgentM m = expandAgentM_states' >>> expandAgentM_errors $ m
