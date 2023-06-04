module AI.Agent.Master where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (runExceptT)
import Type.Proxy (Proxy(..))

_master = Proxy :: Proxy "master"

type Agent state errors m = Agent.Agent state errors Start m

_start = Proxy :: Proxy "start"
data Start (a :: Type) = Start a
derive instance Functor Start

define :: forall state errors m a. Monad m => (Unit -> Agent.M state errors m a) -> Agent.Agent state errors Start m
define main = Agent.define \(Start a) -> do
  void $ main unit
  pure a

run :: forall state errors m. Monad m => Agent state errors m -> state -> m Unit
run master state = do
  let master_id = Agent.new master state
  _ <- runExceptT $ Agent.query master_id $ Start unit
  pure unit
