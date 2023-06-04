module AI.Agent.Chat where

import Prelude

import Data.Functor.Variant as FV
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

-- | A chat agent is an agent that can have a conversation with a single
-- | user. It maintains the history of chat messages.

_chat = Proxy :: Proxy "chat"

type Agent states errors queries m = Agent.Agent (States states) errors (Queries queries) m
type Id states errors queries m = Agent.Id (States states) errors (Queries queries) m
type M states errors m = Agent.M (States states) errors m

type Config =
  { system :: Maybe String
  , history :: Array Chat.Message
  }

type States states =
  ( history :: Array Chat.Message 
  | states )
_history = Proxy :: Proxy "history"

type Queries queries =
  ( prompt :: Prompt
  , getHistory :: GetHistory | queries )

_prompt = Proxy :: Proxy "prompt"
prompt promptMsg k = FV.inj _prompt $ Prompt promptMsg k
data Prompt a = Prompt Chat.Message (Chat.Message -> a)
derive instance Functor Prompt

_getHistory = Proxy :: Proxy "getHistory"
getHistory k = FV.inj _getHistory $ GetHistory k
data GetHistory a = GetHistory (Array Chat.Message -> a)
derive instance Functor GetHistory

new :: forall states errors queries m. Monad m =>
  Nub (States states) (States states) =>
  Agent states errors queries m ->
  Config ->
  Record states ->
  Id states errors queries m
new agent input states = Agent.new agent $
  Record.disjointUnion
    { history: case input.system of
        Nothing -> input.history
        Just str -> [Chat.systemMessage str] <> input.history
    }
    states

define :: forall states errors queries m. Monad m =>
  (forall a. FV.VariantF queries a -> M states errors m a) ->
  (NonEmptyArray Chat.Message -> M states errors m Chat.Message) ->
  Agent states errors queries m
define handleQuery genReply = Agent.define (FV.case_
    # (\_ query -> handleQuery query)
    # FV.on _prompt (\(Prompt promptMsg k) -> do
        history <- gets _.history
        -- append prompt message to history
        st <- modify \st -> st {history = st.history `Array.snoc` promptMsg}
        -- reply
        reply <- genReply $ NonEmptyArray.snoc' history promptMsg
        -- append reply to history
        modify_ \st' -> st' {history = st.history `Array.snoc` reply}
        -- yield reply
        pure $ k reply)
    # FV.on _getHistory (\(GetHistory k) -> k <$> gets _.history))
