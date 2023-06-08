module AI.Agent.Chat.CommandLine where

import Prelude

import AI.Agent as Agent
import AI.Agent.Chat as Chat
import AI.AgentInquiry as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (gets, modify_)
import Data.Array as Array
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Options (Options)
import Data.Show.Generic (genericShow)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Process as Process
import Node.ReadLine as CommandLine
import Node.ReadLine as ReadLine
import Node.ReadLine.Aff as ReadLineAff
import Type.Proxy (Proxy(..))

type Class states errors queries = Agent.Class (States states) (Errors errors) (Queries queries)
type Inst states errors queries = Agent.Inst (States states) (Errors errors) (Queries queries)
type ExtensibleClass states errors queries m = Agent.ExtensibleClass (States states) (Errors errors) queries (Queries queries) m

type States states =
  ( interface :: Maybe ReadLine.Interface 
  | states )

type Errors errors = 
  ( commandLine :: Error 
  | errors )

type Queries queries = Chat.Queries String
  ( open :: Agent.Inquiry Unit Unit
  , close :: Agent.Inquiry Unit Unit
  | queries )

_commandLine = Proxy :: Proxy "commandLine"

define :: forall states errors queries m.
  MonadEffect m => MonadAff m =>
  { interfaceOptions :: Options CommandLine.InterfaceOptions } ->
  ExtensibleClass states errors queries m
define params =
  (Agent.addInquiry _open \_ -> do
    gets _.interface >>= case _ of
      Just _ -> throwError $ V.inj _commandLine OpenWhenOpened
      Nothing -> do
        interface <- liftEffect $ ReadLine.createInterface Process.stdin params.interfaceOptions
        modify_ _{interface = Just interface}) >>>
  (Agent.addInquiry Chat._chat \prompts -> do
    ReadLineAff.question (Array.intercalate "\n\n" prompts) =<< getInterface QuestionWhenClosed) >>>
  (Agent.addInquiry _close \_ -> do
    ReadLineAff.close =<< getInterface CloseWhenClosed)
  where
  getInterface err = gets _.interface >>= case _ of
    Nothing -> throwError $ V.inj _commandLine err
    Just interface -> pure interface

new cls = Agent.extensibleNew cls {interface: Nothing}

-- Queries

_open = Proxy :: Proxy "open"
open = Agent.inquire _open unit

_close = Proxy :: Proxy "close"
close = Agent.inquire _close unit

data Error
  = OpenWhenOpened
  | QuestionWhenClosed
  | CloseWhenClosed

derive instance Generic Error _
instance Show Error where show x = genericShow x