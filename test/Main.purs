module Test.Main where

import Prelude

import AI.Agent.Master (runMasterAgent)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.TestDialogueAgent as TestDialogueAgent

main :: Effect Unit
main = launchAff_ $ runMasterAgent TestDialogueAgent.master