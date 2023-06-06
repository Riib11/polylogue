module AI.Agent.Chat.Echo where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.AgentInquiry as Agent
import API.Chat.OpenAI as ChatOpenAI
import Control.Monad.Error.Class (throwError)
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Type.Proxy (Proxy(..))

-- | A dialogue agent that echos the user's prompt.
define params =
  Agent.addInquiry Chat._chat (Array.uncons >>> case _ of
    Nothing -> pure params.default
    Just {head} -> pure head)
