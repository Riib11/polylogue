module AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import API.Chat.OpenAI as Chat
import Control.Monad.State (gets, modify, modify_)
import Data.Array as Array
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NonEmptyArray
import Data.Maybe (Maybe(..))
import Prim.Row (class Nub)
import Record as Record
import Type.Proxy (Proxy(..))

-- | A dialogue agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

_dialogue = Proxy :: Proxy "dialogue"

type Agent states errors m = Agent.Agent (States states) errors Query m
type Id states errors m = Agent.Id (States states) errors Query m
type M states errors m = Agent.M (States states) errors m

type Input =
  { system :: Maybe String
  , history :: Array Chat.Message
  }

type States states =
  ( history :: Array Chat.Message 
  | states )
_history = Proxy :: Proxy "history"

data Query a
  = Prompt Chat.Message (Chat.Message -> a)
  | GetHistory (Array Chat.Message -> a)
derive instance Functor Query

new :: forall states errors m. Monad m =>
  Nub (States states) (States states) =>
  Agent states errors m ->
  Input ->
  Record states ->
  Id states errors m
new agent input states = Agent.new agent $
  Record.disjointUnion
    { history: case input.system of
        Nothing -> input.history
        Just str -> [Chat.systemMessage str] <> input.history
    }
    states

define :: forall states errors m. Monad m =>
  (NonEmptyArray Chat.Message -> M states errors m Chat.Message) ->
  Agent states errors m
define genReply = Agent.define case _ of
  Prompt promptMsg k -> do
    history <- gets _.history
    -- append prompt message to history
    st <- modify \st -> st {history = st.history `Array.snoc` promptMsg}
    -- reply
    reply <- genReply $ NonEmptyArray.snoc' history promptMsg
    -- append reply to history
    modify_ \st' -> st' {history = st.history `Array.snoc` reply}
    -- yield reply
    pure $ k reply
  GetHistory k -> k <$> gets _.history
