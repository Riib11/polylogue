-- | A manager agent maintains a state with labeled sub-agent instances.
module AI.Agent.Manager where

import Data.Tuple.Nested
import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.Reader (runReaderT)
import Control.Monad.State (class MonadTrans, get, gets, lift, modify_, state)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Functor.Variant as VF
import Data.Symbol (class IsSymbol)
import Data.Tuple (Tuple)
import Data.Variant as V
import Hole (hole)
import Prim.Row (class Cons, class Union)
import Record as R
import Type.Proxy (Proxy(..))

_allSubAgents = Proxy :: Proxy "allSubAgents"
_allSubStates = Proxy :: Proxy "allSubStates"

type ExtensibleAgent allSubAgents allSubStates states errors queries queries_ m = Agent.ExtensibleAgent (States allSubAgents allSubStates states) errors queries_ queries m

type States allSubAgents (allSubStates :: Row Type) states = 
  ( allSubAgents :: Record allSubAgents
  , allSubStates :: Record allSubStates
  | states )

subDo :: forall subLabel subStates subQueries allSubAgents allSubAgents_ allSubStates allSubStates_ states errors m a. IsSymbol subLabel => Cons subLabel (Agent.Agent subStates errors subQueries m) allSubAgents_ allSubAgents => Cons subLabel (Record subStates) allSubStates_ allSubStates => Monad m => Proxy subLabel -> (Agent.QueryF subStates errors subQueries m a) -> Agent.AgentM (States allSubAgents allSubStates states) errors m a
subDo subLabel m = do
  subagent <- gets (_.allSubAgents >>> R.get subLabel)
  allSubStates <- gets (_.allSubStates >>> R.get subLabel)
  lift (Agent.run allSubStates (runReaderT m subagent)) >>= \(res /\ allSubStates') -> do
    modify_ $ R.modify _allSubStates $ R.set subLabel allSubStates'
    case res of
      Left err -> throwError err
      Right a -> pure a


-- !TODO i dont think i should make anything specified to Inquiries -- should
-- just be able to be used anywhere generic queries are used

-- subInquire :: forall subLabel subStates subQueries agents agents_ states errors m a queryLabel subQueries_ input.
--   IsSymbol subLabel => Cons subLabel (Tuple (Agent.Agent subStates errors subQueries m) (Record subStates)) agents_ agents =>
--   IsSymbol queryLabel => Cons queryLabel (Agent.Inquiry input a) subQueries_ subQueries =>
--   Monad m =>
--   Proxy subLabel ->
--   Proxy queryLabel ->
--   input ->
--   Agent.AgentM (States agents states) errors m a
-- subInquire subLabel queryLabel input = 
--   subQuery subLabel (FV.inj queryLabel (Agent.Inquiry input identity))
