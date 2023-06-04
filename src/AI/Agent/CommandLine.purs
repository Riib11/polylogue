module AI.Agent.CommandLine where

import Prelude

import AI.Agent as Agent
import Control.Monad.Error.Class (throwError)
import Control.Monad.State (gets, modify_)
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Options (Options)
import Data.Variant as V
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console as Console
import Node.Process as Process
import Node.ReadLine as ReadLine
import Node.ReadLine.Aff as ReadLineAff
import Prim.Row (class Nub)
import Record (disjointUnion)
import Type.Proxy (Proxy(..))

-- | An `Agent` interface to a command line user interface.

type Agent states errors queries m = 
  Agent.Agent
    (States states)
    (Errors errors)
    (Queries queries)
    m

type States states = (interface :: Maybe ReadLine.Interface | states)
type Errors errors = (commandLine :: Error | errors)
type Queries queries = (question :: Question, open :: Open, close :: Close | queries)
type Id states errors queries m = Agent.Id (States states) (Errors errors) (Queries queries) m
type M states errors m = Agent.M (States states) (Errors errors) m

_question = Proxy :: Proxy "question"
question questionString k = FV.inj _question $ Question questionString k
question' questionString = FV.inj _question $ Question questionString identity
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

type Input = 
  { interfaceOptions :: Options ReadLine.InterfaceOptions
  , promptString :: Maybe String }

_commandLine = Proxy :: Proxy "commandLine"
data Error
  = OpenWhenOpened
  | QuestionWhenClosed
  | CloseWhenClosed

define :: forall states errors queries m. MonadEffect m => MonadAff m => 
  (forall a. FV.VariantF queries a -> M states errors m a) ->
  Input ->
  Agent states errors queries m
define handleQuery input = do
  Agent.define (FV.case_ 
    # (\_ query -> handleQuery query)
    # FV.on _open (\(Open a) -> do
      -- Console.log "[CommandLine] opening interface"
      gets _.interface >>= case _ of
        Nothing -> pure unit
        _ -> throwError $ V.inj _commandLine OpenWhenOpened
      interface <- liftEffect $ ReadLine.createInterface Process.stdin input.interfaceOptions
      modify_ _{interface = Just interface}
      pure a)
    # FV.on _question (\(Question questionString k) -> do
      -- Console.log "[CommandLine] questioning interface"
      k <$> (ReadLineAff.question questionString =<< getInterface QuestionWhenClosed))
    # FV.on _close (\(Close a) -> do
      -- Console.log "[CommandLine] opening interface"
      ReadLineAff.close =<< getInterface CloseWhenClosed
      pure a)
  )
  where
  getInterface err = gets _.interface >>= case _ of
    Nothing -> throwError $ V.inj _commandLine err
    Just interface -> pure interface

new :: forall states errors queries m. 
  Nub (States states) (States states) =>
  Agent states errors queries m ->
  Record states ->
  Id states errors queries m
new agent states = Agent.new agent
  (disjointUnion {interface: Nothing} states)
