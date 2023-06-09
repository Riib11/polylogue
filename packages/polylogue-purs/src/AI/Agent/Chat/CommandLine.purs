-- | A chat agent interface to the user's command line.
module AI.Agent.Chat.CommandLine where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.AgentInquiry (Inquiry, defineInquiry, inquire) as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (gets, modify_)
import Data.Array as Array
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Options (Options)
import Data.Show.Generic (genericShow)
import Data.Traversable (traverse)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Process as Process
import Node.ReadLine as CommandLine
import Node.ReadLine as ReadLine
import Node.ReadLine.Aff as ReadLineAff
import Prim.Row (class Nub)
import Type.Proxy (Proxy(..))

_interface = Proxy :: Proxy "interface"
_commandLine = Proxy :: Proxy "commandLine"
_open = Proxy :: Proxy "open"
_close = Proxy :: Proxy "close"

type States states = Chat.States
  ( interface :: Maybe ReadLine.Interface 
  | states )

type Errors errors = Chat.Errors
  ( commandLine :: Error 
  | errors )

type Queries msg queries = Chat.Queries msg
  ( open :: Agent.Inquiry Unit Unit
  , close :: Agent.Inquiry Unit Unit
  | queries )

extend :: forall msg states errors queries m.
  MonadEffect m => MonadAff m =>
  { interfaceOptions :: Options CommandLine.InterfaceOptions 
  , parse :: String -> Agent.AgentM (States states) (Errors errors) m msg
  , makePrompt :: Array msg -> Agent.AgentM (States states) (Errors errors) m String } ->
  Agent.ExtensibleAgent (States states) (Errors errors) queries (Queries msg queries) m
extend params =
  (Agent.defineInquiry _open \_ -> do
    gets _.interface >>= case _ of
      Just _ -> throwError $ V.inj _commandLine OpenWhenOpened
      Nothing -> do
        interface <- liftEffect $ ReadLine.createInterface Process.stdin params.interfaceOptions
        modify_ _{interface = Just interface}) >>>
  (Agent.defineInquiry Chat._chat \msgs -> do
    interface <- getInterface QuestionWhenClosed
    prompt <- params.makePrompt msgs
    str <- ReadLineAff.question prompt interface
    params.parse str) >>>
  (Agent.defineInquiry _close \_ -> do
    ReadLineAff.close =<< getInterface CloseWhenClosed)
  where
  getInterface err = gets _.interface >>= case _ of
    Nothing -> throwError $ V.inj _commandLine err
    Just interface -> pure interface

extendInit :: forall states m. Applicative m => Nub (States states) (States states) => Agent.ExtensibleInitialization states (States states) m
extendInit = Agent.extendInit {interface: Nothing}

open :: forall msg states errors queries m. Monad m => Agent.QueryF (States states) (Errors errors) (Queries msg queries) m Unit
open = Agent.inquire _open unit

close :: forall msg states errors queries m. Monad m => Agent.QueryF (States states) (Errors errors) (Queries msg queries) m Unit
close = Agent.inquire _close unit

data Error
  = OpenWhenOpened
  | QuestionWhenClosed
  | CloseWhenClosed

derive instance Generic Error _
instance Show Error where show x = genericShow x