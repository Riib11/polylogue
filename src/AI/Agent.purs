module AI.Agent where

import Data.UUID (UUID)
import Prelude
import Data.Tuple.Nested ((/\))
import Control.Monad.Except (ExceptT)
import Control.Monad.Reader (ReaderT, runReaderT)
import Control.Monad.State (StateT, runStateT)
import Data.Variant (Variant)

--
-- agents
--

newtype
  Agent
    (label :: Symbol)
    (input :: Type)
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type)
    (m :: Type -> Type)
  =
  Agent
    ( forall a. 
      query a ->
      AgentM input state errors m a
    )

type AgentM input state errors m =
  ReaderT input 
    (StateT state
      (ExceptT (Variant errors) m))

runAgent (Agent f) = f

--
-- registering agents
--

newtype
  AgentId 
    (label :: Symbol)
    (input :: Type)
    (state :: Type)
    (errors :: Row Type)
    (query :: Type -> Type) 
    (m :: Type -> Type)
  = 
  AgentId UUID

derive newtype instance Eq (AgentId label input state errors query m)
derive newtype instance Ord (AgentId label input state errors query m)

foreign import register :: forall label input state errors query m. 
  Agent label input state errors query m ->
  input ->
  state -> 
  AgentId label input state errors query m

foreign import getAgent :: forall label input state errors query m. 
  AgentId label input state errors query m ->
  Agent label input state errors query m

foreign import getAgentInput :: forall label input state errors query m.
  AgentId label input state errors query m ->
  input

foreign import getAgentState :: forall label input state errors query m.
  AgentId label input state errors query m ->
  state

foreign import setAgentState :: forall label input state errors query m.
  AgentId label input state errors query m ->
  state ->
  Unit

query :: forall label input state errors query m a. Monad m =>
  AgentId label input state errors query m ->
  query a ->
  ExceptT (Variant errors) m a
query agent_id q = do
  -- get agent, input, and current state
  let agent = getAgent agent_id
  let input = getAgentInput agent_id
  let state = getAgentState agent_id
  -- run agent query
  a /\ state' <- flip runStateT state $ flip runReaderT input $ runAgent agent q
  -- update state
  let _ = setAgentState agent_id state'
  pure a

ask agent_id f = query agent_id (f identity)

tell agent_id f = void $ query agent_id (f unit)
