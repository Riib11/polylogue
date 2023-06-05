module AI.Agent.CommandLine where

import Prelude

import AI.Agent as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (gets, modify_)
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Variant as V
import Effect.Class (liftEffect)
import Node.Process as Process
import Node.ReadLine as ReadLine
import Node.ReadLine.Aff as ReadLineAff
import Record as R
import Type.Proxy (Proxy(..))

-- | An `Agent` interface to a command line user interface.

define config =
  (Agent.addQuery _open (\(Open a) -> do
    gets _.interface >>= case _ of
      Nothing -> pure unit
      _ -> throwError $ V.inj _commandLine OpenWhenOpened
    interface <- liftEffect $ ReadLine.createInterface Process.stdin config.interfaceOptions
    modify_ _{interface = Just interface}
    pure a)) >>>
  (Agent.addQuery _question (\(Question questionString k) -> do
    k <$> (ReadLineAff.question questionString =<< getInterface QuestionWhenClosed))) >>>
  (Agent.addQuery _close (\(Close a) -> do
    ReadLineAff.close =<< getInterface CloseWhenClosed
    pure a))
  where
  getInterface err = gets _.interface >>= case _ of
    Nothing -> throwError $ V.inj _commandLine err
    Just interface -> pure interface

new cls = Agent.new cls <<< R.union 
  {interface: Nothing}

_question = Proxy :: Proxy "question"
question questionString k = FV.inj _question $ Question questionString k
data Question a = Question String (String -> a)
derive instance Functor Question

_open = Proxy :: Proxy "open"
open = FV.inj _open <<< Open
data Open a = Open a
derive instance Functor Open

_close = Proxy :: Proxy "close"
close = FV.inj _close <<< Close
data Close a = Close a
derive instance Functor Close

_commandLine = Proxy :: Proxy "commandLine"
data Error
  = OpenWhenOpened
  | QuestionWhenClosed
  | CloseWhenClosed
