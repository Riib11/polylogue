module AI.Agent.Master where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (ExceptT, runExceptT)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Variant as V
import Effect.Class (class MonadEffect)
import Effect.Class.Console as Console
import Type.Proxy (Proxy(..))

_master = Proxy :: Proxy "master"

type Agent states errors m = Agent.Agent states errors (start :: Start) m

_start = Proxy :: Proxy "start"
data Start (a :: Type) = Start a
derive instance Functor Start

define :: forall states errors m. Monad m =>
  (Unit -> Agent.M states errors m Unit) -> 
  Agent states errors m
define main = Agent.define (FV.case_
  # FV.on _start (\(Start a) -> do
    void $ main unit
    pure a)
  )

run :: forall states errors m. 
  Monad m =>
  MonadEffect m =>
  Agent states errors (ExceptT (V.Variant errors) m) ->
  Record states ->
  (V.Variant errors -> String) ->
  m Unit
run master states showError = do
  let master_id = Agent.new master states
  runExceptT (Agent.query master_id (FV.inj _start (Start unit))) >>= case _ of
    Left err -> Console.log $ "Error in master.run:\n\n" <> showError err
    Right _ -> pure unit
