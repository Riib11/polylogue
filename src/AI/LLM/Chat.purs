module AI.LLM.Chat where

import Prelude

import Control.Assert (assertI)
import Control.Assert.Assertions (just)
import Control.Monad.Error.Class (throwError)
import Control.Monad.Except (ExceptT, lift)
import Data.Array as Array
import Data.Enum (class BoundedEnum, class Enum)
import Data.Finite (finiteBottom, finiteCardinality, finiteFromEnum, finitePred, finiteSucc, finiteToEnum, finiteTop)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Refined (class Refined, makeRefined)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Node.Process as Process
import Type.Proxy (Proxy(..))

--------------------------------------------------------------------------------
-- Model
--------------------------------------------------------------------------------

gpt_4 ∷ Model
gpt_4 = Model "gpt-4"

gpt_3p5_turbo ∷ Model
gpt_3p5_turbo = Model "gpt-3.5-turbo"

models :: Array Model
models =
  [ gpt_4
  , gpt_3p5_turbo
  ]

newtype Model = Model String
derive newtype instance Eq Model
derive newtype instance Ord Model
derive newtype instance Show Model

instance Enum Model where
  succ = finiteSucc models
  pred = finitePred models

instance Bounded Model where
  bottom = finiteBottom models
  top = finiteTop models

instance BoundedEnum Model where
  cardinality = finiteCardinality models
  toEnum = finiteToEnum models
  fromEnum = finiteFromEnum models

--------------------------------------------------------------------------------
-- Temperature
--------------------------------------------------------------------------------

newtype Temperature = Temperature Number

instance Refined Number Temperature where
  refinement n = if 0.0 <= n && n <= 1.0 then pure (Temperature n) else
    throwError $ "temperature is out of bounds: " <> show n

--------------------------------------------------------------------------------
-- Role
--------------------------------------------------------------------------------

user ∷ Role
user = Role "user"

system ∷ Role
system = Role "system"

assistant ∷ Role
assistant = Role "assistant"

roles :: Array Role
roles = [user, system, assistant]

newtype Role = Role String
derive newtype instance Eq Role
derive newtype instance Ord Role
derive newtype instance Show Role

instance Enum Role where
  succ = finiteSucc roles
  pred = finitePred roles

instance Bounded Role where
  bottom = finiteBottom roles
  top = finiteTop roles

instance BoundedEnum Role where
  cardinality = finiteCardinality roles
  toEnum = finiteToEnum roles
  fromEnum = finiteFromEnum roles

--------------------------------------------------------------------------------
-- Message-related types
--------------------------------------------------------------------------------

type Request
  = { model :: Model
    , messages :: Array Message
    , temperature :: Temperature }

type Message
  = { role :: Role
    , content :: String }

prettyMessage :: forall t84.
  { content :: String
  , role :: Role
  | t84
  }
  -> String
prettyMessage {role: Role role, content} = "[" <> role <> "] " <> content

userMessage :: String -> Message
userMessage content = {role: user, content}

assistantMessage :: String -> Message
assistantMessage content = {role: assistant, content}

systemMessage :: String -> Message
systemMessage content = {role: system, content}

type Response
  = { id :: String
    , object :: String
    , created :: Number
    , usage ::
        { prompt_tokens :: Number
        , completion_tokens :: Number
        , total_tokens :: Number
        }
    , choices :: Array ChatChoice }

type ChatChoice
  = { message :: Message
    , finish_reason :: String
    , index :: Int }

type ChatOptions
  = { model :: Model
    , temperature :: Temperature }

defaultChatOptions :: ChatOptions
defaultChatOptions =
  { model: gpt_3p5_turbo
  , temperature: makeRefined 0.6 }

--------------------------------------------------------------------------------
-- Client
--------------------------------------------------------------------------------

foreign import data Client :: Type

type ClientConfiguration =
  { organization :: String
  , apiKey :: String }

foreign import _makeClient :: ClientConfiguration -> Effect Client

-- | Make a client instance. If no configuration is provided, then use
-- | environment-specified values.
makeClient :: Maybe ClientConfiguration -> Effect Client
makeClient Nothing = do
  apiKey <- assertI just <$> Process.lookupEnv "OPENAI_API_KEY"
  organization <- assertI just <$> Process.lookupEnv "OPENAI_ORGANIZATION_ID"
  _makeClient {apiKey, organization}
makeClient (Just config) = _makeClient config

--------------------------------------------------------------------------------
-- createCompletion
--------------------------------------------------------------------------------

foreign import _createCompletion :: Client -> Request -> EffectFnAff Response

createCompletion :: forall m. MonadAff m => Client -> Request -> m Response
createCompletion client req = liftAff <<< fromEffectFnAff $
  _createCompletion client req

data Error
  = EmptyResponseChoices
  | BadFinishReason String

derive instance Generic Error _
instance Show Error where show x = genericShow x

type Config = 
  { chatOptions :: ChatOptions
  , client :: Client }

_chat = Proxy :: Proxy "chat"

chat :: forall m. MonadAff m =>
  Config ->
  Array Message ->
  ExceptT Error m Message
chat config msgs = do
  response <- lift $
    createCompletion
      config.client
      { model: config.chatOptions.model
      , temperature: config.chatOptions.temperature
      , messages: msgs }
  case Array.uncons response.choices of
    Nothing -> throwError EmptyResponseChoices
    Just { head: choice }
      | choice.finish_reason == "stop" -> pure choice.message
      | otherwise -> throwError $ BadFinishReason choice.finish_reason
