module AI.Agent.Master where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (lift, runExceptT)
import Control.Monad.Reader (runReaderT)
import Control.Monad.State (runStateT)
import Data.Functor.Variant (inj)
import Data.Functor.Variant as FV
import Type.Proxy (Proxy(..))

_master = Proxy :: Proxy "master"

type MasterAgent m = Agent.Agent
  {}
  ()
  Start
  m

_start = Proxy :: Proxy "start"
data Start (a :: Type) = Start a
derive instance Functor Start

runMasterAgent :: forall m. Monad m => MasterAgent m -> m Unit
runMasterAgent master = do
  let master_id = Agent.register master {}
  _ <- runExceptT $ Agent.query master_id $ Start unit
  pure unit
