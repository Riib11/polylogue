module Main where

import Prelude

import AI.LLM.Chat (chat, defaultChatOptions, makeClient, userMessage)
import Control.Monad.Except (runExceptT)
import Control.Monad.Reader (runReaderT)
import Effect as Effect
import Effect.Aff as Aff
import Effect.Class.Console (log)
import Effect.ReadLine (readLine, runReadLine)

-- main :: Effect.Effect Unit
-- main = do
--   let msgs =
--         [ userMessage "List the days of the week."
--         ]
  
--   client <- makeClient
--     { apiKey: "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"
--     , organization: "org-7xbFVKWnHoxCwR2Nvlu8KDcj"
--     }
--   let ctx = 
--         { client
--         , chatOptions: defaultChatOptions
--         }

--   Aff.launchAff_ do
--     res <- runExceptT (runReaderT (chat msgs) ctx)
--     log "result:"
--     log $ show res
--     pure unit


main :: Effect.Effect Unit
main = do
  str <- runReadLine $ readLine
  log str
  pure unit