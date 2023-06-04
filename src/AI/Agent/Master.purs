module AI.Agent.Master where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (runExceptT)
import Type.Proxy (Proxy(..))

_master = Proxy :: Proxy "master"

type Agent states errors m = Agent.Agent states errors Start m

_start = Proxy :: Proxy "start"
data Start (a :: Type) = Start a
derive instance Functor Start

define :: forall states errors m a. Monad m => (Unit -> Agent.M states errors m a) -> Agent.Agent states errors Start m
define main = Agent.define \(Start a) -> do
  void $ main unit
  pure a

run :: forall states errors m. Monad m => Agent states errors m -> Record states -> m Unit
run master states = do
  let master_id = Agent.new master states
  _ <- runExceptT $ Agent.query master_id $ Start unit
  pure unit
