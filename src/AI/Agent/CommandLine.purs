-- | An agent interface for a command line interface with the user.
module AI.Agent.CommandLine where

import Prelude

import AI.Agent as Agent
import AI.AgentInquiry as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (gets, modify_)
import Data.Maybe (Maybe(..))
import Data.Options (Options)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Process as Process
import Node.ReadLine as CommandLine
import Node.ReadLine as ReadLine
import Node.ReadLine.Aff as ReadLineAff
import Type.Proxy (Proxy(..))

type States states = 
  ( interface :: Maybe ReadLine.Interface 
  | states )

type Errors errors = 
  ( commandLine :: Error 
  | errors )

type Queries queries =
  ( open :: Agent.Inquiry Unit Unit
  , close :: Agent.Inquiry Unit Unit
  , question :: Agent.Inquiry String String
  | queries )

_commandLine = Proxy :: Proxy "commandLine"

define :: forall states errors queries m.
  MonadEffect m => MonadAff m =>
  { interfaceOptions :: Options CommandLine.InterfaceOptions } ->
  Agent.ExtensibleClass (States states) (Errors errors) queries (Queries queries) m
define params =
  (Agent.addInquiry _open \_ -> do
    gets _.interface >>= case _ of
      Just _ -> throwError $ V.inj _commandLine OpenWhenOpened
      Nothing -> do
        interface <- liftEffect $ ReadLine.createInterface Process.stdin params.interfaceOptions
        modify_ _{interface = Just interface}) >>>
  (Agent.addInquiry _question \questionString -> do
    ReadLineAff.question questionString =<< getInterface QuestionWhenClosed) >>>
  (Agent.addInquiry _close \_ -> do
    ReadLineAff.close =<< getInterface CloseWhenClosed)
  where
  getInterface err = gets _.interface >>= case _ of
    Nothing -> throwError $ V.inj _commandLine err
    Just interface -> pure interface

-- Queries

_question = Proxy :: Proxy "question"
question questionString = Agent.inquire _question questionString

_open = Proxy :: Proxy "open"
open = Agent.inquire _open unit

_close = Proxy :: Proxy "close"
close = Agent.inquire _close unit

data Error
  = OpenWhenOpened
  | QuestionWhenClosed
  | CloseWhenClosed
