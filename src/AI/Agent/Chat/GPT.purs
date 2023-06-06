module AI.Agent.Chat.GPT where

-- import Prelude

-- import AI.Agent.Chat as Chat
-- import API.Chat.OpenAI as ChatOpenAI
-- import Control.Monad.Except (runExceptT, throwError)
-- import Data.Array.NonEmpty as NonEmptyArray
-- import Data.Either (Either(..))
-- import Data.Functor.Variant as FV
-- import Data.Variant (inj)
-- import Effect.Aff.Class (class MonadAff)

-- define config = Chat.define 
--   {reply: \history -> do
--     runExceptT (ChatOpenAI.chat config (NonEmptyArray.toArray history)) >>= case _ of
--       Left chatError -> throwError $ inj Chat._chat chatError
--       Right reply -> pure reply}
