module AI.AgentRegistry where

-- import Prelude

-- import AI.Agent as Agent
-- import Control.Monad.Error.Class (class MonadError, class MonadThrow, throwError)
-- import Control.Monad.Except (class MonadError, class MonadTrans, ExceptT, lift, runExceptT)
-- import Control.Monad.State (class MonadState, StateT, get, gets, modify_, put, runStateT)
-- import Data.Either (Either(..))
-- import Data.Either.Nested (type (\/))
-- import Data.Functor.Variant as FV
-- import Data.Symbol (class IsSymbol)
-- import Data.Tuple.Nested (type (/\), (/\))
-- import Data.Variant as V
-- import Effect.Aff.Class (class MonadAff)
-- import Effect.Class (class MonadEffect)
-- import Prim.Row (class Cons, class Union)
-- import Record as R
-- import Record.Unsafe.Union as UnsafeUnion
-- import Type.Proxy (Proxy(..))
-- import Unsafe.Coerce as Coerce

-- -- | An agent registry provides an implicit environment of agents that are
-- -- | identified by static label.

-- class 
--   MonadState (Record agents) m <= 
--   MonadRegistry agents m

-- class 
--   ( IsSymbol label
--   , MonadError (V.Variant errors) m
--   , Cons label (Agent.Inst states errors queries m) otherAgents agents
--   , MonadRegistry agents m ) <=
--   ConsRegistry label states errors queries otherAgents agents m
--   | label -> states errors queries otherAgents agents m

-- type RegistryM agents m = StateT (Record agents) m

-- query :: forall label states errors queries otherAgents agents m a.
--   ConsRegistry label states errors queries otherAgents agents m =>
--   FV.VariantF queries a ->
--   Proxy label ->
--   m a
-- query q label = do
--   inst <- gets $ R.get label
--   inst' /\ a <- Agent.query q inst
--   modify_ $ R.set label inst' 
--   pure a

-- ask label f = query label (f identity)

-- tell label f = query label (f unit)
