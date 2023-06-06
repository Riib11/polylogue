module AI.Agent.CommandLine where

-- import Prelude

-- import AI.Agent as Agent
-- import Control.Monad.Error.Class (throwError)
-- import Control.Monad.State (gets, modify_)
-- import Data.Functor.Variant as FV
-- import Data.Maybe (Maybe(..))
-- import Data.Variant as V
-- import Effect.Class (liftEffect)
-- import Node.Process as Process
-- import Node.ReadLine as ReadLine
-- import Node.ReadLine.Aff as ReadLineAff
-- import Record as R
-- import Type.Proxy (Proxy(..))

-- -- | An `Agent` interface to a command line user interface.
-- define config =
--   (Agent.addQuery _open (\(Agent.Inquiry a k) -> do
--     gets _.interface >>= case _ of
--       Just _ -> throwError $ V.inj _commandLine OpenWhenOpened
--       Nothing -> do
--         interface <- liftEffect $ ReadLine.createInterface Process.stdin config.interfaceOptions
--         modify_ _{interface = Just interface}
--         pure (k a)
--     )) >>>
--   (Agent.addQuery _question (\(Agent.Inquiry {questionString} k) -> do
--     k <$> (ReadLineAff.question questionString =<< getInterface QuestionWhenClosed))) >>>
--   (Agent.addQuery _close (\(Agent.Inquiry a k) -> do
--     ReadLineAff.close =<< getInterface CloseWhenClosed
--     pure (k a)))
--   where
--   getInterface err = gets _.interface >>= case _ of
--     Nothing -> throwError $ V.inj _commandLine err
--     Just interface -> pure interface

-- new cls = Agent.new cls
--   { interface: Nothing }

-- -- Queries

-- _question = Proxy :: Proxy "question"
-- question questionString = Agent.ask $ Agent.makeAsk _question {questionString}

-- _open = Proxy :: Proxy "open"
-- open = Agent.tell $ Agent.makeTell _open

-- _close = Proxy :: Proxy "close"
-- close = Agent.tell $ Agent.makeTell _close

-- _commandLine = Proxy :: Proxy "commandLine"
-- data Error
--   = OpenWhenOpened
--   | QuestionWhenClosed
--   | CloseWhenClosed
