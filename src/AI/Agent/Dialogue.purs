module AI.Agent.Dialogue where

import Prelude

import AI.Agent as Agent
import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Control.Monad.State (StateT)
import Data.Either (Either(..))
import Data.Functor.Variant as FV
import Data.Maybe (Maybe(..))
import Data.Variant as V
import Hole (hole)
import Record as Record
import Type.Proxy (Proxy(..))

-- _dialogue = Proxy :: Proxy "dialogue"

-- type Agent states errors m = Master.Agent states errors m
-- type Id states errors m = Agent.Id (States states) errors m
-- type M states errors m = Agent.M (States states) errors m

-- type Config states errors queries m =
--   { handleReply1 :: forall a. a -> ExceptT (V.Variant errors) (StateT (Record states) (ExceptT (V.Variant errors) m)) (Maybe (FV.VariantF queries a))
--   , handleReply2 :: forall a. a -> ExceptT (V.Variant errors) (StateT (Record states) (ExceptT (V.Variant errors) m)) (Maybe (FV.VariantF queries a))
--   , initialize :: forall a. FV.VariantF queries a
--   }
-- type States (states :: Row Type) = (| states)

-- define :: forall states states1 queries states2 errors m.
--   Monad m => 
--   Config states errors queries m ->
--   Id states2 errors queries (ExceptT (V.Variant errors) (StateT (Record states) (ExceptT (V.Variant errors) m))) ->
--   Id states1 errors queries (ExceptT (V.Variant errors) (StateT (Record states) (ExceptT (V.Variant errors) m))) ->
--   Master.Agent states errors m

-- define config chat1_id chat2_id = Master.define \_ -> do
--   let loop reply1 = do
--         (Agent.query chat2_id >=> config.handleReply1) reply1 >>= case _ of
--           Nothing -> pure unit
--           Just reply2 -> (Agent.query chat1_id >=> config.handleReply2) reply2 >>= case _ of
--             Nothing -> pure unit
--             Just reply1' -> loop reply1'
  
--   result <- runExceptT do 
--       (Agent.query chat1_id >=> config.handleReply1) config.initialize >>= case _ of
--         Nothing -> pure unit
--         Just reply1 -> loop reply1
  
--   case result of
--     Left err -> throwError err
--     Right _ -> pure unit
