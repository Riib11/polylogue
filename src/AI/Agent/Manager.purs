module AI.Agent.Manager where

import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (class MonadTrans, get, gets, lift, modify_)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Functor.Variant as VF
import Data.Symbol (class IsSymbol)
import Hole (hole)
import Prim.Row (class Cons, class Union)
import Record as R
import Type.Proxy (Proxy(..))

-- | A manager agent maintains a state with labeled agent instances.

type Class agents states errors m a = Agent.Class (States agents states) errors m a
type Inst agents states errors m a = Agent.Inst (States agents states) errors m a
type AgentM agents states errors m a = Agent.AgentM (States agents states) errors m a

type States (agents :: Row Type) states = (agents :: Record agents | states)

_agents = Proxy :: Proxy "agents"

subQuery :: forall 
  subLabel subStates subErrors subQueries
  agents_ states_ errors_ 
  agents states errors
  m a.
  -- subagent is among manager's agents
  IsSymbol subLabel =>
  Union subErrors errors_ errors =>
  Cons subLabel (Agent.Inst subStates subErrors subQueries m) agents_ agents =>
  Monad m =>
  -- subAgent's label
  Proxy subLabel ->
  -- subAgent's query input
  Agent.QueryInput subQueries a ->
  AgentM agents states errors m a
subQuery subLabel subInput = do
  Agent.Inst subCls subStates <- gets (_.agents >>> R.get subLabel)
  lift (Agent.runAgentM subStates (Agent.query subInput subCls)) >>= case _ of
    Left err -> Agent.throwExpandedError err
    Right (a /\ subStates') -> do
      modify_ $ R.modify _agents $ R.set subLabel (Agent.Inst subCls subStates')
      pure a

subInquire subLabel label input = 
  subQuery subLabel (FV.inj label (Agent.Inquiry input identity))