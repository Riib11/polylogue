module AI.Agent.Master where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (runExceptT)
import Data.Functor.Variant as FV
import Type.Proxy (Proxy(..))

_master = Proxy :: Proxy "master"

type Agent states errors queries m = Agent.Agent states errors (start :: Start | queries) m

_start = Proxy :: Proxy "start"
data Start (a :: Type) = Start a
derive instance Functor Start

define :: forall states errors queries m. Monad m =>
  (forall a. FV.VariantF queries a -> Agent.M states errors m a) ->
  (Unit -> Agent.M states errors m Unit) -> 
  Agent states errors queries m
define handleQuery main = Agent.define (FV.case_
  # (\_ query -> handleQuery query)
  # FV.on _start (\(Start a) -> do
    void $ main unit
    pure a)
  )

run :: forall states errors queries m. Monad m => Agent states errors queries m -> Record states -> m Unit
run master states = do
  let master_id = Agent.new master states
  _ <- runExceptT $ Agent.query master_id $ FV.inj _start (Start unit)
  pure unit
