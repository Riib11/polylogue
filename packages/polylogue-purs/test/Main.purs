module Test.Main where

import Prelude

import API.Chat.OpenAI (_chat)
import Data.Variant as V
import Dotenv as Dotenv
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.AI.Agent.Chat as TestAgentChat

-- main :: Effect Unit
-- main = launchAff_ do
--   Dotenv.loadFile
--   Master.run TestAgentChat.master {} (V.case_
--     # V.on _chat show)

