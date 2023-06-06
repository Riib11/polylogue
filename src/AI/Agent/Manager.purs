module AI.Agent.Manager where

import Prelude

import AI.Agent as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (get, gets, lift, modify_)
import Data.Either (Either(..))
import Data.Symbol (class IsSymbol)
import Data.Tuple.Nested
import Hole (hole)
import Prim.Row (class Cons)
import Record as R
import Type.Proxy (Proxy(..))

-- | A manager agent maintains a state with labeled agent instances.

new :: forall (agents :: Row Type) states errors queries m.
  { agents :: Record agents } ->
  Agent.Class (agents :: Record agents | states) errors queries m ->
  Record states -> 
  Agent.Inst (agents :: Record agents | states) errors queries m
new config cls = Agent.new cls
  { agents: config.agents
  }

_agents = Proxy :: Proxy "agents"

sub :: forall label agents agents' states errors queries m a.
  IsSymbol label =>
  Monad m =>
  Cons label (Agent.Inst states errors queries m) agents' agents =>
  Proxy label ->
  ( Agent.Inst states errors queries m -> 
    m (Agent.Inst states errors queries m /\ a) ) ->
  Agent.AgentM (agents :: Record agents | states) errors m a
sub label f = do
  subInst <- gets (_.agents >>> R.get label)
  subInst' /\ a <- lift $ f subInst
  modify_ $ R.modify _agents $ R.set label subInst'
  pure a
