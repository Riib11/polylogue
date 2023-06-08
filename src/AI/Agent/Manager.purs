module AI.Agent.Manager where

import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (class MonadTrans, get, gets, lift, modify_, state)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Functor.Variant as VF
import Data.Symbol (class IsSymbol)
import Data.Variant as V
import Hole (hole)
import Prim.Row (class Cons, class Union)
import Record as R
import Type.Proxy (Proxy(..))

type States (agents :: Row Type) states = (agents :: Record agents | states)

_agents = Proxy :: Proxy "agents"

-- | A manager agent maintains a state with labeled sub-agent instances.
subQuery :: forall subLabel subStates subQueries agents agents_ states errors m a.
  IsSymbol subLabel =>
  Cons subLabel (Agent.Agent subStates errors subQueries m /\ Record subStates) agents_ agents =>
  Monad m =>
  Proxy subLabel ->
  Agent.QueryInput subQueries a ->
  Agent.AgentM (States agents states) errors m a
subQuery subLabel input = do
  agent /\ states <- gets (_.agents >>> R.get subLabel)
  lift (Agent.runAgentM states (Agent.query input agent)) >>= \(res /\ states') -> do
    modify_ $ R.modify _agents $ R.set subLabel (agent /\ states')
    case res of
      Left err -> throwError err
      Right a -> pure a

subInquire subLabel queryLabel input = 
  subQuery subLabel (FV.inj queryLabel (Agent.Inquiry input identity))
